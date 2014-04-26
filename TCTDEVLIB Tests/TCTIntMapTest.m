//
//  TCTIntMapTest.m
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-26.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TCTIntMap.h"

@interface TCTIntMapTest : XCTestCase

@end

@implementation TCTIntMapTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIntIntMap
{
    TCTIntIntMap *map = [TCTIntIntMap map];
    
    XCTAssert([map removeIntValueForIntKey:0] == NSNotFound);
    
    XCTAssert([map count] == 0, @"count failed");
    XCTAssert([map intValueForIntKey:0] == NSNotFound, @"test get integer not exists failed");
    [map setIntValue:100 forIntKey:0];
    XCTAssert([map intValueForIntKey:0] == 100, @"test set value failed");
    XCTAssert([map count] == 1, @"count failed");
    XCTAssert([map containsIntKey:0], @"");
    XCTAssert(![map containsIntKey:1], @"");
    XCTAssert([map setIntValue:200 forIntKey:0]==100, @"return of set is failed");
    XCTAssert([map intValueForIntKey:0]==200, @"");
    XCTAssert([map removeIntValueForIntKey:0]==200, @"");
    XCTAssert([map intValueForIntKey:0]==NSNotFound, @"");
}

- (void)testIntObjectMap
{
    TCTIntObjectMap *map = [TCTIntObjectMap map];
    
    XCTAssertEqual(0, [map count]);
    XCTAssertNil([map objectForIntKey:0]);
    XCTAssertNil([map setObject:@"0" forIntKey:0]);
    XCTAssertEqual(@"0", [map objectForIntKey:0]);
    XCTAssertEqual(1, [map count]);
    XCTAssertEqual(@"0", [map setObject:@"00" forIntKey:0]);
    map[1] = @"1";
    XCTAssertEqual(2, [map count]);
    XCTAssertEqual(@"00", map[0]);
    XCTAssertEqual(@"00", [map setObject:nil forIntKey:0]);
    XCTAssertEqual(1, [map count]);
    map[1] = nil;
    XCTAssertEqual(0, [map count]);
    map[2] = @"3";
    XCTAssertEqual(@"3", [map removeObjectForIntKey:2]);
    XCTAssertEqual(0, [map count]);
}

- (void)testIntWeakObjectMap
{
    TCTIntWeakObjectMap *map = [TCTIntWeakObjectMap map];
    
    XCTAssertEqual(0, [map count]);
    XCTAssertNil([map objectForIntKey:0]);
    XCTAssertNil([map setObject:@"0" forIntKey:0]);
    XCTAssertEqual(@"0", [map objectForIntKey:0]);
    XCTAssertEqual(1, [map count]);
    XCTAssertEqual(@"0", [map setObject:@"00" forIntKey:0]);
    map[1] = @"1";
    XCTAssertEqual(2, [map count]);
    XCTAssertEqual(@"00", map[0]);
    XCTAssertEqual(@"00", [map setObject:nil forIntKey:0]);
    XCTAssertEqual(1, [map count]);
    map[1] = nil;
    XCTAssertEqual(0, [map count]);
    map[2] = @"3";
    XCTAssertEqual(@"3", [map removeObjectForIntKey:2]);
    XCTAssertEqual(0, [map count]);
    
    @autoreleasepool {
        id obj = [[NSObject alloc] init];
        map[0] = obj;
        XCTAssertEqual(obj, map[0]);
        XCTAssertEqual(1, [map count]);
    }
    
    XCTAssertNil(map[0]);
    XCTAssertEqual(0, [map count]);
}

@end
