//
//  NSString+AC.m
//  ACUtils
//
//  Created by Dave Lilly on 9/26/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "NSString+AC.h"

@implementation NSString (AC)
#pragma mark- Class methods
+ (NSString*) stringWithInt:(int) i
{
    return [NSString stringWithFormat:@"%d", i];
}

+ (NSString*) stringWithFloat:(float) f
{
    return [NSString stringWithFormat:@"%.2f", f];
}

#pragma mark- Instance methods
- (BOOL) matches:(NSString *) string options:(NSStringCompareOptions) options {
    return [self rangeOfString:string options:options].location != NSNotFound;
}

- (BOOL) matches:(NSString *) string {
    return [self matches:string options:NSCaseInsensitiveSearch];
}

-(NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger) indexOf:(NSString*) str
{
    return [self rangeOfString:str].location;
}

- (NSUInteger) lastIndexOf:(NSString *)str
{
    return [self rangeOfString:str options:NSBackwardsSearch].location;
}

- (NSString*) substringToIndexOf:(NSString*) str
{
    return [self substringToIndexOf:str inclusive:NO];
}

- (NSString*) substringToIndexOf:(NSString*) str inclusive:(BOOL) inclusive
{
    NSUInteger offset = inclusive ? [str length] : 0;
    return [self matches:str] ? [self substringToIndex:[self indexOf:str] + offset] : self;
}

- (NSString*) substringToLastIndexOf:(NSString*) str
{
    return [self substringToLastIndexOf:str inclusive:NO];
}

- (NSString*) substringToLastIndexOf:(NSString*) str inclusive:(BOOL) inclusive
{
    NSUInteger offset = inclusive ? [str length] : 0;
    return [self matches:str] ? [self substringToIndex:[self lastIndexOf:str] + offset] : self;
}

- (NSString*) substringFromIndexOf:(NSString*) str inclusive:(BOOL) inclusive
{
    NSUInteger offset = inclusive ? 0 : [str length];
    return [self matches:str] ? [self substringFromIndex:[self indexOf:str] + offset] : self;
}

- (NSString*) substringFromIndexOf:(NSString*) str
{
    return [self substringFromIndexOf:str inclusive:NO];
}

- (NSString*) substringFromLastIndexOf:(NSString*) str inclusive:(BOOL) inclusive
{
    NSUInteger offset = inclusive ? 0 : [str length];
    return [self matches:str] ? [self substringFromIndex:[self lastIndexOf:str] + offset] : self;
}

- (NSString*) substringFromLastIndexOf:(NSString*) str
{
    return [self substringFromLastIndexOf:str inclusive:NO];
}

- (NSString*) substringFromIndexOf:(NSString*) fromStr toIndexOf:(NSString*) toStr
{
    return [[self substringFromIndexOf:fromStr] substringToIndexOf:toStr];
}

- (NSString*) stringByRemovingOccurrencesOfString:(NSString*) str
{
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

- (NSString*) stringByRemovingOccurrencesOfCharactersInString:(NSString*) str
{
    NSString* retStr = [self copy];
    
    for (int i = 0; i < [str length]; i++)
    {
        NSString* c = [str substringWithRange:NSMakeRange(i, 1)];
        retStr = [retStr stringByRemovingOccurrencesOfString:c];
    }
    
    return retStr;
}

- (BOOL) endsWith:(NSString*) str
{
    if ([str length] > [self length]) {return NO;}
    NSString* lastSubstring = [self substringFromIndex:([self length] - [str length])];
    return [lastSubstring isEqualToString:str];
}

- (BOOL) startsWith:(NSString *)string
{
    if (string.length > self.length) {return NO;}
    NSString* sub = [self substringToIndex:string.length];
    return [sub isEqualToString:string];
}

- (NSString*) ucFirst
{
    NSString* first = [[self substringToIndex:1] uppercaseString];
    return [first stringByAppendingString:[self substringFromIndex:1]];
}

- (NSString*) pad:(int) length
{
    return [self pad:length padChar:@" "];
}

- (NSString*) pad:(int) length padChar:(NSString*) padChar
{
    return [self pad:length padChar:padChar frontPad:YES];
}

- (NSString*) pad:(int) length padChar:(NSString*) padChar frontPad:(BOOL) frontPad
{
    NSMutableString* str = [self mutableCopy];
    while ([str length] < length)
    {
        if (frontPad)
        {
            [str insertString:padChar atIndex:0];
        }
        else
        {
            [str appendString:padChar];
        }
    }
    return str;
}
@end
