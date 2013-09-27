//
//  CopyUserProfile.h
//  ACLib
//
//  Created by Dave Lilly on 9/24/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CopyUserProfile : NSObject
@property (nonatomic, retain) NSString* copyID;
@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;
@property (nonatomic) BOOL isDeveloper;
@property (nonatomic, retain) NSDate* createdDate;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* usedStorage;
@property (nonatomic, retain) NSString* quotaStorage;
@property (nonatomic, retain) NSString* savedStorage;
+ (id) profileWithDict:(NSDictionary*) dict;
- (NSString*) profileUserName;
- (NSString*) profileCreationDate;
@end
