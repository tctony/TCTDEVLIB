//
//  TCTBase64Test.m
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-19.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Foundation+TCTAddtions.h"

@interface TCTBase64Test : XCTestCase

@property (nonatomic, strong) NSArray *cases;
@property (nonatomic, strong) NSArray *invalidBase64Strings;
@end

@implementation TCTBase64Test

- (void)setUp
{
    [super setUp];
    
    self.cases = @[
                   @[@"", @""],
                   @[@"a", @"YQ=="],
                   @[@"aa", @"YWE="],
                   @[@"aaa", @"YWFh"],
                   @[@"aaa", @"YWFh"],
                   @[@"Send reinforcements" , @"U2VuZCByZWluZm9yY2VtZW50cw=="],
                   @[@"Now is the time for all good coders\nto learn Ruby", @"Tm93IGlzIHRoZSB0aW1lIGZvciBhbGwgZ29vZCBjb2RlcnMKdG8gbGVhcm4gUnVieQ=="],
                   @[@"This is line one\nThis is line two\nThis is line three\nAnd so on...", @"VGhpcyBpcyBsaW5lIG9uZQpUaGlzIGlzIGxpbmUgdHdvClRoaXMgaXMgbGluZSB0aHJlZQpBbmQgc28gb24uLi4="],
                   @[@"\0", @"AA=="],
                   @[@"\0\0", @"AAA="],
                   @[@"\0\0\0", @"AAAA"],
                   ];
    
    self.invalidBase64Strings = @[
                                 @"^",
                                 @"A",
                                 @"A^",
                                 @"AA",
                                 @"AA=",
                                 @"AA==A",
                                 @"AA===",
                                 @"AA=x",
                                 @"AAA",
                                 @"AAA^",
                                 @"AA==AA==",
                                 ];
}

- (void)tearDown
{
    self.cases = nil;
    self.invalidBase64Strings = nil;
    
    [super tearDown];
}

- (void)testEncode
{
    [self.cases enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects([[obj objectAtIndex:0] tct_base64EncodedString], [obj objectAtIndex:1], @"test encode failed on test case %lu", idx);
    }];
}

- (void)testDecode
{
    [self.cases enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects([obj objectAtIndex:0], [[obj objectAtIndex:1] tct_base64DecodedString], @"test decode failed on test case %lu", idx);
    }];
}

- (void)testDecodeInputContainWhitespaceCharacters
{
    XCTAssertEqualObjects(@"aaa", [@"Y W\nFh" tct_base64DecodedString], @"test decode with white space characters in input failed");
}

- (void)testDecodeInvalidInput
{
    [self.invalidBase64Strings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertNil([obj tct_base64DecodedString], @"test decode with invalid input failed on test case %lu", idx);
    }];
}

@end
