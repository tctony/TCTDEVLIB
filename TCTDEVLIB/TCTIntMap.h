//
//  TCTIntMap.h
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-26.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTIntIntMap : NSObject

+ (instancetype)map;

- (instancetype)init;
- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (NSInteger)setIntValue:(NSInteger)value forIntKey:(NSInteger)key;
- (NSInteger)removeIntValueForIntKey:(NSInteger)key;
- (NSInteger)intValueForIntKey:(NSInteger)key;
- (BOOL)containsIntKey:(NSInteger)key;
- (NSUInteger)count;

@end


@interface TCTIntObjectMap : NSObject

+ (instancetype)map;

- (instancetype)init;
- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (id)setObject:(id)obj forIntKey:(NSInteger)key;
- (id)removeObjectForIntKey:(NSInteger)key;
- (id)objectForIntKey:(NSInteger)key;
- (BOOL)containsIntKey:(NSInteger)key;
- (NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSInteger)key;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)key;

@end


@interface TCTIntWeakObjectMap : NSObject

+ (instancetype)map;

- (instancetype)init;
- (instancetype)initWithCapaticy:(NSInteger)capacity;

- (id)setObject:(id)obj forIntKey:(NSInteger)key;
- (id)removeObjectForIntKey:(NSInteger)key;
- (id)objectForIntKey:(NSInteger)key;
- (BOOL)containsIntKey:(NSInteger)key;
- (NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSInteger)key;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)key;

- (void)clean;

@end
