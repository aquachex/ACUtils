//
//  CopyFileSystemNode.h
//  ACLib
//
//  Created by Dave Lilly on 9/25/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CopyFileSystemNode : NSObject
@property (nonatomic, retain) NSString* _id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* path;
@property (nonatomic, retain) NSString* type;
@property (nonatomic) BOOL isStub;
@property (nonatomic, retain) NSDate* lastSynced;
@property (nonatomic, retain) NSString* size;
@property (nonatomic, retain) NSArray* children;
@property (nonatomic, retain) NSString* token;
@property (nonatomic, retain) NSString* permissions;
@property (nonatomic) BOOL isSyncing;
@property (nonatomic) BOOL isPublic;
@property (nonatomic) BOOL recipientConfirmed;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* revisionID;
@property (nonatomic, retain) NSString* thumb;
@property (nonatomic, retain) NSString* share;
@property (nonatomic, retain) NSString* mimeType;
+ (CopyFileSystemNode*) fileSystemNodeWithDict:(NSDictionary*) dict;
- (NSString*) lastSyncedDate;
- (BOOL) hasLocalCopy;
@end
