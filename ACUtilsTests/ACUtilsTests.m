//
//  ACUtilsTests.m
//  ACUtilsTests
//
//  Created by Dave Lilly on 9/26/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ACUtils.h"

@interface ACUtilsTests : XCTestCase

@end

@implementation ACUtilsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testIsEmptyString
{
    [self isEmpty:@"Hi there"];
    [self isEmpty:@"  "];
    [self isEmpty:@""];
}

- (void) isEmpty:(NSString*) test
{
    BOOL empty = isEmpty(test);
    NSLog(@"String (%@) is empty? %d", test, empty);
    if (empty && [[test trim] length] > 0)
    {
        XCTFail(@"Non-empty string (%@) reports as empty", test);
    }
}

@end
