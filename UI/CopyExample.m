//
//  CopyExample.m
//  ACLib
//
//  Created by Dave Lilly on 9/24/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "CopyExample.h"

@implementation CopyExample
- (void) userProfileLoaded:(CopyUserProfile *)userProfile
{
    NSLog(@"%@", [userProfile description]);
}
@end
