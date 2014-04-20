//
//  TCTUrlQueryStringTest.m
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-20.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Foundation+TCTAddtions.h"

@interface TCTUrlQueryStringTest : XCTestCase

@end

@implementation TCTUrlQueryStringTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBuildUrlQueryStringWithBoundryInput
{
    XCTAssertEqualObjects(@"", [NSString tct_buildUrlString:nil params:nil], @"test with nil nil failed");
    
    XCTAssertEqualObjects(@"aaa", [NSString tct_buildUrlString:@"aaa" params:nil], @"test with aaa nil failed");
    
    NSDictionary *params = @{@"a": @1, @"b": @2 };
    XCTAssertEqualObjects(@"a=1&b=2", [NSString tct_buildUrlString:nil params:params], @"test with nil {a:1, b:2} failed");
    
    XCTAssertEqualObjects(@"aaa?a=1&b=2", [NSString tct_buildUrlString:@"aaa" params:params], @"");
    
    XCTAssertEqualObjects(@"aaa?_=0&a=1&b=2", [NSString tct_buildUrlString:@"aaa?_=0" params:params], @"");
    
    XCTAssertEqualObjects(@"aaa?_=0&a=1&b=2#ooooo", [NSString tct_buildUrlString:@"aaa?_=0#ooooo" params:params], @"");
    
    XCTAssertEqualObjects(@"aaa", [NSString tct_buildUrlString:@"aaa" params:(NSDictionary *)@[]], @"");
    
    XCTAssertEqualObjects(@"aaa?_=0", [NSString tct_buildUrlString:@"aaa?_=0" params:(NSDictionary *)@[]], @"");
    
    XCTAssertEqualObjects(@"aaa?_=0#ooooo", [NSString tct_buildUrlString:@"aaa?_=0#ooooo" params:(NSDictionary *)@[]], @"");
    
    XCTAssertNil([NSString tct_buildUrlString:(NSString *)@1 params:nil], @"test with @1 nil failed");
    XCTAssertNil([NSString tct_buildUrlString:(NSString *)@1 params:params], @"test with @1 nil failed");
}

- (void)testBuildUrlQueryStringPercentEscape
{
    NSDictionary *params = @{ @"a!#$&'()*+,/:;=?@[]": @"1!#$&'()*+,/:;=?@[]" };
    XCTAssertEqualObjects(@"aaa?a%21%23%24%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40[]=1%21%23%24%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D", [NSString tct_buildUrlString:@"aaa" params:params], @"");
}

- (void)testBuildUrlQueryStringWithVaryData
{
    NSString *url = @"aaa";
    NSDictionary *params = @{ @"a": @1, @"b": @2 };
    XCTAssertEqualObjects(@"aaa?a=1&b=2", [NSString tct_buildUrlString:url params:params], @"");
    
    params = @{ @"a": @[@1, @1], @"b": @{@"c": @3} };
    XCTAssertEqualObjects(@"aaa?a=%5B%0A%20%201%2C%0A%20%201%0A%5D&b=%7B%0A%20%20%22c%22%20%3A%203%0A%7D", [NSString tct_buildUrlString:url params:params], @"");
    
    TCTUrlQueryStringTest *obj = [[TCTUrlQueryStringTest alloc] init];
    params = @{ @"obj": obj };
    NSString *result = [NSString stringWithFormat:@"aaa?obj=%@", [[obj description] tct_urlParamValueEncodedString]];
    XCTAssertEqualObjects(result, [NSString tct_buildUrlString:url params:params], @"");
    
    char a[10] = "1234567890";
    NSData *data = [NSData dataWithBytes:a length:10];
    result = [NSString stringWithFormat:@"aaa?data=%@", [[data tct_base64EncodedString] tct_urlParamValueEncodedString]];
    params = @{ @"data": data };
    XCTAssertEqualObjects(result, [NSString tct_buildUrlString:url params:params], @"");
}

@end
