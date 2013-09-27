//
//  CopySession.m
//  ACLib
//
//  Created by Dave Lilly on 9/24/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "CopySession.h"
#import "CopyHTTPFetcher.h"
#import "CopyServiceDelegate.h"
#import "CopyExample.h"

CopySession* copySession;

@interface CopySession ()
@property (nonatomic, retain) GTMOAuthAuthentication* auth;
@property (nonatomic) BOOL isLoggedIn;
@property (nonatomic, retain) CopyExample* example;
@end

@implementation CopySession
+ (CopySession*) sharedInstance
{
    if (!copySession)
    {
        copySession = [CopySession new];
    }
    return copySession;
}

- (id) init
{
    self = [super init];
    self.auth = [self myCustomAuth];
    self.example = [CopyExample new];
    [self performSelectorInBackground:@selector(login) withObject:nil];
    return self;
}

#pragma mark- Authentication
- (void) login
{
    self.isLoggedIn = NO;
    
    if (self.auth) {
        BOOL didAuth = [GTMOAuthViewControllerTouch authorizeFromKeychainForName:@"Copy"
                                                                  authentication:self.auth];
        self.isLoggedIn = [self.auth canAuthorize];
        
        if (self.isLoggedIn)
        {
            NSLog(@"Authenticated to Copy!");
            [self loadUserProfile:self.example];
            [[NSNotificationCenter defaultCenter] postNotificationName:kCopySessionAuthenticatedNotification object:nil];
        }
        else
        {
            [self signInToCustomService];
        }
    }
    else
    {
        [self signInToCustomService];
    }
}

- (void)signInToCustomService {
    NSLog(@"Attempting to authenticate to Copy...");
    NSURL *requestURL = [NSURL URLWithString:@"http://api.copy.com/oauth/request"];
    NSURL *accessURL = [NSURL URLWithString:@"http://api.copy.com/oauth/access"];
    NSURL *authorizeURL = [NSURL URLWithString:@"http://www.copy.com/applications/authorize"];
    
    NSMutableDictionary* permissions = [NSMutableDictionary new];
    permissions[@"profile"] = @{@"read": @"true", @"write": @"true", @"email": @{@"read": @"true"}};
    permissions[@"inbox"] = @{@"read": @"true"};
    permissions[@"links"] = @{@"read": @"true", @"write": @"true"};
    permissions[@"filesystem"] = @{@"read": @"true", @"write": @"true"};
    NSString *scope = [permissions JSONString];
    
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    
    // set the callback URL to which the site should redirect, and for which
    // the OAuth controller should look to determine when sign-in has
    // finished or been canceled
    //
    // This URL does not need to be for an actual web page
    [auth setCallback:@"http://www.aquachex.org/"];
    
    // Display the autentication view
    GTMOAuthViewControllerTouch *viewController = [[[GTMOAuthViewControllerTouch alloc] initWithScope:scope
                                                                                             language:nil
                                                                                      requestTokenURL:requestURL
                                                                                    authorizeTokenURL:authorizeURL
                                                                                       accessTokenURL:accessURL
                                                                                       authentication:auth
                                                                                       appServiceName:@"Copy"
                                                                                             delegate:self
                                                                                     finishedSelector:@selector(viewController:finishedWithAuth:error:)] autorelease];
    
    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [navVC.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:viewController action:@selector(doneButtonPressed)];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:navVC animated:YES completion:nil];
}

- (void)viewController:(GTMOAuthViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuthAuthentication *)auth
                 error:(NSError *)error {
    [viewController dismissViewControllerAnimated:YES completion:nil];
    if (error != nil) {
        NSLog(@"Auth failed: %@", [error localizedDescription]);
    } else {
        NSLog(@"Auth succeeded!");
        self.auth = auth;
    }
}

- (GTMOAuthAuthentication *)myCustomAuth
{
    GTMOAuthAuthentication *authorization;
    authorization = [[[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                                 consumerKey:kConsumerKey
                                                                  privateKey:kConsumerSecret] autorelease];
    
    authorization.serviceProvider = @"Copy";
    return authorization;
}

#pragma mark- Profile Operations
- (void) loadUserProfile:(id<CopyServiceDelegate>) delegate
{
    NSString* profileURL = @"https://api.copy.com/rest/user";
    CopyHTTPFetcher* request = [CopyHTTPFetcher fetcherWithURLString:profileURL authorizer:self.auth];
    request.copyDelegate = delegate;
    [request beginFetchWithDelegate:self didFinishSelector:@selector(profileRequestFinished:finishedWithData:error:)];
}

- (void) profileRequestFinished:(CopyHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error
{
    if (error != nil)
    {
        NSLog(@"Request to %@ failed: %@", fetcher.url, [error localizedDescription]);
    }
    else
    {
        NSDictionary* dict = [[[NSString alloc] initWithData:retrievedData encoding:NSUTF8StringEncoding] objectFromJSONString];
        [fetcher.copyDelegate userProfileLoaded:[CopyUserProfile profileWithDict:dict]];
    }
}

- (void) loadMetadataForPath:(NSString*) path delegate:(id<CopyServiceDelegate>) delegate
{
    NSString* metadataURL = [@"https://api.copy.com/rest/meta/copy" stringByAppendingString:path];
    CopyHTTPFetcher* request = [CopyHTTPFetcher fetcherWithURLString:metadataURL authorizer:self.auth];
    request.copyDelegate = delegate;
    [request beginFetchWithDelegate:self didFinishSelector:@selector(metadataRequestFinished:finishedWithData:error:)];
}

- (void) metadataRequestFinished:(CopyHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error
{
    if (error != nil)
    {
        NSLog(@"Request to %@ failed: %@", fetcher.url, [error localizedDescription]);
    }
    else
    {
        NSDictionary* dict = [[[NSString alloc] initWithData:retrievedData encoding:NSUTF8StringEncoding] objectFromJSONString];
        NSLog(@"Metadata loaded: %@", dict);

        [fetcher.copyDelegate metadataLoaded:[CopyFileSystemNode fileSystemNodeWithDict:dict]];
    }
}
@end
