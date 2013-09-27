//
//  CopyUserProfile.m
//  ACLib
//
//  Created by Dave Lilly on 9/24/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "CopyUserProfile.h"
#import "NSNumber+AC.h"

@implementation CopyUserProfile
+ (id) profileWithDict:(NSDictionary*) dict
{
    CopyUserProfile* profile = [CopyUserProfile new];
    profile.firstName = dict[@"first_name"];
    profile.lastName = dict[@"last_name"];
    profile.isDeveloper = [dict[@"developer"] boolValue];
    profile.usedStorage = [dict[@"storage"][@"used"] byteDisplayValue];
    profile.quotaStorage = [dict[@"storage"][@"quota"] byteDisplayValue];
    profile.savedStorage = [dict[@"storage"][@"saved"] byteDisplayValue];
    profile.copyID = dict[@"id"];
    profile.email = dict[@"email"];
    profile.createdDate = [dict[@"created_time"] dateValue];
    return profile;
}

- (NSString*) profileUserName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSString*) profileCreationDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    return [dateFormat stringFromDate:self.createdDate];
}

- (NSString*) description
{
    NSMutableString* desc = [NSMutableString new];
    [desc appendString:@"Copy User Profile\n-----------------\n\n"];
    [desc appendFormat:@"\tUser ID: %@\n", self.copyID];
    [desc appendFormat:@"\tUser Name: %@\n", [self profileUserName]];
    [desc appendFormat:@"\tUser email: %@\n", self.email];
    [desc appendFormat:@"\tCreated date: %@\n", [self profileCreationDate]];
    [desc appendFormat:@"\tDeveloper: %s\n", self.isDeveloper ? "yes" : "no"];
    [desc appendFormat:@"\tStorage quota: %@\n", self.quotaStorage];
    [desc appendFormat:@"\tStorage used: %@\n", self.usedStorage];
    [desc appendFormat:@"\tStorage saved: %@\n", self.savedStorage];
    return desc;
}
@end
