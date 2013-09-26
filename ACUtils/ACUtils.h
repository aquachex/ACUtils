//
//  ACUtils.h
//  ACUtils
//
//  Created by Dave Lilly on 9/26/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+AC.h"

static inline BOOL isEmpty(id obj)
{
    if ([obj isKindOfClass:[NSString class]])
    {
        obj = [obj trim];
    }
    
    return obj == [NSNull null]
        || ([obj respondsToSelector:@selector(length)] && [obj length] == 0)
        || ([obj respondsToSelector:@selector(count)] && [obj count] == 0);
}

@interface ACUtils : NSObject

@end
