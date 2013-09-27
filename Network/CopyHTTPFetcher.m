//
//  CopyHTTPFetcher.m
//  iPad-MPOS
//
//  Created by Dave Lilly on 6/3/13.
//
//

#import "CopyHTTPFetcher.h"

@implementation CopyHTTPFetcher
+ (id) fetcherWithURLString:(NSString*) string authorizer:(GTMOAuthAuthentication*) auth
{
    return [self fetcherWithURLString:string authorizer:auth extraHeaders:nil httpMethod:@"GET"];
}

+ (id) fetcherWithURLString:(NSString*) string authorizer:(GTMOAuthAuthentication*) auth extraHeaders:(NSDictionary*) extraHeaders httpMethod:(NSString*) httpMethod
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
    [request setValue:@"1" forHTTPHeaderField:@"X-Api-Version"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:httpMethod];

    for (NSString* key in [extraHeaders allKeys])
    {
        NSString* value = [extraHeaders objectForKey:key];
        [request setValue:value forHTTPHeaderField:key];
    }
    
    CopyHTTPFetcher* fetcher = [[CopyHTTPFetcher alloc] initWithRequest:request];
    fetcher.url = string;
    fetcher.authorizer = auth;
    return fetcher;
}

+ (GTMHTTPUploadFetcher*) uploadFetcherWithURLString:(NSString*) string file:(NSString*) file authorizer:(GTMOAuthAuthentication*) auth
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
    [request setValue:@"1" forHTTPHeaderField:@"X-Api-Version"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"multipart/form-data; boundary=END_OF_PART" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    NSData* data = [NSData dataWithContentsOfFile:file];
    GTMHTTPUploadFetcher* fetcher = [GTMHTTPUploadFetcher uploadFetcherWithRequest:request uploadData:data uploadMIMEType:@"application/xml" chunkSize:1024 fetcherService:nil];
    fetcher.authorizer = auth;
    return fetcher;
}
@end	
