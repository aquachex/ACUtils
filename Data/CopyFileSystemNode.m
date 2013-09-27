//
//  CopyFileSystemNode.m
//  ACLib
//
//  Created by Dave Lilly on 9/25/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "CopyFileSystemNode.h"
#import "NSNumber+AC.h"

@implementation CopyFileSystemNode
+ (CopyFileSystemNode*) fileSystemNodeWithDict:(NSDictionary*) dict
{
    CopyFileSystemNode* node = [CopyFileSystemNode new];
    node._id = dict[@"id"];
    node.name = dict[@"name"];
    node.type = dict[@"type"];
    node.path = dict[@"path"];
    node.mimeType = dict[@"mime_type"];
    
    if (![dict[@"date_last_synced"] isKindOfClass:[NSNull class]])
    {
        node.lastSynced = [dict[@"date_last_synced"] dateValue];
    }

    node.size = [dict[@"size"] byteDisplayValue];
    
    NSMutableArray* children = [NSMutableArray new];
    for (NSDictionary* childDict in dict[@"children"])
    {
        CopyFileSystemNode* child = [CopyFileSystemNode fileSystemNodeWithDict:childDict];
        [children addObject:child];
    }
    node.children = children;
    
    return node;
}

- (NSString*) lastSyncedDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    return [dateFormat stringFromDate:self.lastSynced];
}

- (BOOL) hasLocalCopy
{
    return YES;
}

- (NSString*) description
{
    NSMutableString* desc = [NSMutableString new];
    [desc appendFormat:@"\n"];
    [desc appendFormat:@"ID: %@\n", self._id];
    [desc appendFormat:@"Name: %@\n", self.name];
    [desc appendFormat:@"Type: %@\n", self.type];
    [desc appendFormat:@"Path: %@\n", self.path];
    [desc appendFormat:@"Last synced: %@\n", [self lastSyncedDate]];
    [desc appendFormat:@"Size: %@\n", self.size];
    return desc;
}
@end
