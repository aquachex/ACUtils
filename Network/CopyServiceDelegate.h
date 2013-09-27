//
//  CopyServiceDelegate.h
//  ACLib
//
//  Created by Dave Lilly on 9/24/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CopyUserProfile.h"
#import "CopyFileSystemNode.h"

@protocol CopyServiceDelegate <NSObject>
- (void) userProfileLoaded:(CopyUserProfile*) userProfile;
- (void) metadataLoaded:(CopyFileSystemNode*) metadata;
@end
