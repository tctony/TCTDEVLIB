//
//  TCTIntMap.mm
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-26.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import "TCTIntMap.h"

#define kTCTIntMapDefaultCapacity    4

#import <unordered_map>
typedef std::unordered_map<NSInteger, NSInteger> _TCTIntIntMap;
typedef std::unordered_map<NSInteger, id> _TCTIntObjectMap;
typedef std::unordered_map<NSInteger, __weak id> _TCTIntWeakObjectMap;

@implementation TCTIntIntMap
{
    _TCTIntIntMap _map;
}

+ (instancetype)map
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    return [self initWithCapacity:kTCTIntMapDefaultCapacity];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self) {
        _map.reserve(capacity);
    }
    
    return self;
}

- (NSInteger)setIntValue:(NSInteger)value forIntKey:(NSInteger)key
{
    NSInteger old = NSNotFound;
    
    if (value == NSNotFound) {
        old = [self removeIntValueForIntKey:key];
    }
    else {
        _TCTIntIntMap::iterator itr = _map.find(key);
        if (itr != _map.end()) {
            old = itr->second;
            itr->second = value;
        }
        else {
            _map[key] = value;
        }
    }
    
    return old;
}

- (NSInteger)removeIntValueForIntKey:(NSInteger)key
{
    NSInteger old = NSNotFound;
    
    _TCTIntIntMap::iterator itr = _map.find(key);
    if (itr != _map.end()) {
        old = itr->second;
        _map.erase(itr);
    }
    
    return old;
}

- (NSInteger)intValueForIntKey:(NSInteger)key
{
    _TCTIntIntMap::iterator itr = _map.find(key);
    return itr != _map.end() ? itr->second : NSNotFound;
}

- (BOOL)containsIntKey:(NSInteger)key
{
    return _map.find(key) != _map.end();
}

- (NSUInteger)count
{
    return _map.size();
}

@end


@implementation TCTIntObjectMap
{
    _TCTIntObjectMap _map;
}

+ (instancetype)map
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    return [self initWithCapacity:kTCTIntMapDefaultCapacity];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self) {
        _map.reserve(capacity);
    }
    
    return self;
}

- (id)setObject:(id)obj forIntKey:(NSInteger)key
{
    id old = nil;
    if (!obj) {
        old = [self removeObjectForIntKey:key];
    }
    else {
        _TCTIntObjectMap::iterator itr = _map.find(key);
        if (itr != _map.end()) {
            old = itr->second;
            itr->second = obj;
        }
        else {
            _map[key] = obj;
        }
    }
    
    return old;
}

- (id)removeObjectForIntKey:(NSInteger)key
{
    id old = nil;
    
    _TCTIntObjectMap::iterator itr = _map.find(key);
    if (itr != _map.end()) {
        old = itr->second;
        _map.erase(itr);
    }
    
    return old;
}

- (id)objectForIntKey:(NSInteger)key
{
    _TCTIntObjectMap::iterator itr = _map.find(key);
    return itr != _map.end() ? itr->second : nil;
}

- (BOOL)containsIntKey:(NSInteger)key
{
    return _map.find(key) != _map.end();
}

- (NSUInteger)count
{
    return _map.size();
}

- (id)objectAtIndexedSubscript:(NSInteger)key
{
    return [self objectForIntKey:key];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)key
{
    [self setObject:obj forIntKey:key];
}

@end


@implementation TCTIntWeakObjectMap
{
    _TCTIntWeakObjectMap _map;
}

+ (instancetype)map
{
    return  [[[self class] alloc] init];
}

- (instancetype)init
{
    return [self initWithCapaticy:kTCTIntMapDefaultCapacity];
}

- (instancetype)initWithCapaticy:(NSInteger)capacity
{
    self = [super init];
    if (self) {
        _map.reserve(capacity);
    }
    
    return self;
}

- (id)setObject:(id)obj forIntKey:(NSInteger)key
{
    id old = nil;
    
    if (!obj) {
        old = [self removeObjectForIntKey:key];
    }
    else {
        _TCTIntWeakObjectMap::iterator itr = _map.find(key);
        if (itr != _map.end()) {
            old = itr->second;
            itr->second = obj;
        }
        else {
            _map[key] = obj;
        }
    }
    
    return old;
}

- (id)removeObjectForIntKey:(NSInteger)key
{
    id old = nil;
    
    _TCTIntWeakObjectMap::iterator itr = _map.find(key);
    if (itr != _map.end()) {
        old = itr->second;
        _map.erase(itr);
    }
    
    return old;
}

- (id)objectForIntKey:(NSInteger)key
{
    _TCTIntWeakObjectMap::iterator itr = _map.find(key);
    return itr != _map.end() ? itr->second : nil;
}

- (BOOL)containsIntKey:(NSInteger)key
{
    [self clean];
    return _map.find(key) != _map.end();
}

- (NSUInteger)count
{
    [self clean];
    return _map.size();
}

- (id)objectAtIndexedSubscript:(NSInteger)key
{
    return [self objectForIntKey:key];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)key
{
    [self setObject:obj forIntKey:key];
}

- (void)clean
{
    for (_TCTIntWeakObjectMap::iterator itr = _map.begin(); itr != _map.end(); ++itr) {
        if (!itr->second) {
            _map.erase(itr);
        }
    }
}

@end
