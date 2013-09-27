//
//  CopySession.h
//  ACLib
//
//  Created by Dave Lilly on 9/24/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "GTMOAuthAuthentication.h"
#import "GTMOAuthViewControllerTouch.h"
#import "AppDelegate.h"
#import "CopyUserProfile.h"
#import "CopyServiceDelegate.h"

#define kConsumerKey                            @"9rsLOA1PyikfDLIzVbxqgJzBbghlRpBt"
#define kConsumerSecret                         @"UjcX1u7oirwJ72dguZl5VXDVQPk2jUWPFuFZ1spwsDtS3RQ6"
#define kCopySessionAuthenticatedNotification   @"kCopySessionAuthenticatedNotification"

@interface CopySession : NSObject
+ (CopySession*) sharedInstance;
- (void) loadUserProfile:(id<CopyServiceDelegate>) delegate;
- (void) loadMetadataForPath:(NSString*) path delegate:(id<CopyServiceDelegate>) delegate;
@end
