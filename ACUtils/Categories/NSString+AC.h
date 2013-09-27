//
//  NSString+AC.h
//  ACUtils
//
//  Created by Dave Lilly on 9/26/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AC)
// Class methods
+ (NSString*) stringWithInt:(int) i;
+ (NSString*) stringWithFloat:(float) i;

// Instance methods
- (BOOL) matches:(NSString*) filterText;
- (BOOL) matches:(NSString *) string options:(NSStringCompareOptions) options;
- (NSString*)trim;
- (NSUInteger) indexOf:(NSString*) str;
- (NSUInteger) lastIndexOf:(NSString*) str;
- (NSString*) substringToIndexOf:(NSString*) str;
- (NSString*) substringToIndexOf:(NSString*) str inclusive:(BOOL) inclusive;
- (NSString*) substringToLastIndexOf:(NSString*) str;
- (NSString*) substringToLastIndexOf:(NSString*) str inclusive:(BOOL) inclusive;
- (NSString*) substringFromIndexOf:(NSString*) str;
- (NSString*) substringFromIndexOf:(NSString*) str inclusive:(BOOL) inclusive;
- (NSString*) substringFromLastIndexOf:(NSString*) str;
- (NSString*) substringFromLastIndexOf:(NSString*) str inclusive:(BOOL) inclusive;
- (NSString*) substringFromIndexOf:(NSString*) fromStr toIndexOf:(NSString*) toStr;
- (NSString*) ucFirst;
- (NSString*) stringByRemovingOccurrencesOfString:(NSString*) str;
- (NSString*) stringByRemovingOccurrencesOfCharactersInString:(NSString*) str;
- (BOOL) endsWith:(NSString*) str;
- (BOOL) startsWith:(NSString*) string;
@end
