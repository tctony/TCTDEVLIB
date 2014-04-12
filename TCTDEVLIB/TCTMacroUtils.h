//
//  TCTMacroUtils.h
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-12.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import <Foundation/NSObjCRuntime.h>


#define EMPTY_MACRO do {} while(0)

#if __has_attribute(objc_requires_super)
#define TCT_REQUIRES_SUPER __attribute__((objc_requires_super))
#else
#define TCT_REQUIRES_SUPER
#endif

#if __has_attribute(deprecated)
#define TCT_DEPRECATED __attribute__((deprecated))
#else
#define TCT_DEPRECATED
#endif

#if __has_attribute(unavailable)
#define TCT_UNAVAILABLE __attribute__((unavailable))
#else
#define TCT_UNAVAILABLE
#endif

#if __has_attribute(nonnull)
#define TCT_NON_NULL __attribute__((nonnull))
#else
#define TCT_NON_NULL
#endif

#define TCT_INVOKE_BLOCK(block, ...) \
    do { \
        if ((block)) { (block)(__VA_ARGS__); } \
    } while(0)

#define $(...) ([NSString stringWithFormat:__VA_ARGS__, nil]);

#define TCT_ENCODE(value, key, type) ([aCoder encode##type:value forKey:key])
#define __TCT_DECODE(key, type, suffix) ([aDecoder decode##type##suffix:key])
#define TCT_DECODE(key, type) (__TCT_DECODE(key, type, ForKey))

#define TCT_STRINGIFY(x) @#x
#define TCT_P_ENCODE(x, type) TCT_ENCODE(x, TCT_STRINGIFY(x), type)
#define TCT_P_DECODE(x, type) TCT_DECODE(TCT_STRINGIFY(x), type)

