//
//  CopyHTTPFetcher.h
//  iPad-MPOS
//
//  Created by Dave Lilly on 6/3/13.
//
//

#import "GTMHTTPFetcher.h"
#import "GTMOAuthAuthentication.h"
#import "GTMHTTPUploadFetcher.h"
#import "CopyServiceDelegate.h"

typedef enum copyRequestTypes
{
    CopyRequestTypeProfile,
    CopyRequestTypeMetadata
} CopyRequestType;

@interface CopyHTTPFetcher : GTMHTTPFetcher
@property (nonatomic) CopyRequestType requestType;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) id<CopyServiceDelegate> copyDelegate;
+ (id) fetcherWithURLString:(NSString*) string authorizer:(GTMOAuthAuthentication*) auth;
+ (id) fetcherWithURLString:(NSString*) string authorizer:(GTMOAuthAuthentication*) auth extraHeaders:(NSDictionary*) extraHeaders httpMethod:(NSString*) httpMethod;
+ (GTMHTTPUploadFetcher*) uploadFetcherWithURLString:(NSString*) string file:(NSString*) file authorizer:(GTMOAuthAuthentication*) auth;
@end
