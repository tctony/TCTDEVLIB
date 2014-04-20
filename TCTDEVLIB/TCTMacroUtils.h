//
//  TCTMacroUtils.h
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-12.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import <Foundation/NSObjCRuntime.h>


#define EMPTY_MACRO do {} while(0)

#if __has_feature(objc_arc)
#define TCT_RELEASE(p)      ((p) = nil)
#define TCT_RETAIN(p)       (p)
#define TCT_AUTORELEASE     (p)
#define TCT_SUPER_DEALLOC
#else
#define TCT_RELEASE(p)      ({ [(p) release]; (p) = nil; })
#define TCT_RETAIN(p)       ([(p) retain])
#define TCT_AUTORELEASE     ([(p) autorelease])
#define TCT_SUPER_DEALLOC   ([super dealloc])
#endif

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

#define TCT_UNUSED_VAR(x) (void)(x)

#define $(...) ([NSString stringWithFormat:__VA_ARGS__, nil])

#define TCT_ENCODE(value, key, type) ([aCoder encode##type:value forKey:key])
#define __TCT_DECODE(key, type, suffix) ([aDecoder decode##type##suffix:key])
#define TCT_DECODE(key, type) (__TCT_DECODE(key, type, ForKey))

#define TCT_STRINGIFY(x) @#x
#define TCT_P_ENCODE(x, type) TCT_ENCODE(x, TCT_STRINGIFY(x), type)
#define TCT_P_DECODE(x, type) TCT_DECODE(TCT_STRINGIFY(x), type)

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define HRGB(rgb) RGB((rgb)>>16&0xff, (rgb)>>8&0xff, (rgb)&0xff)

#define TCT_DEFAULT_STATUSBAR_HEIGHT        (20.0f)
#define TCT_SCREEN_BOUNDS                   ([[UIScreen mainScreen] bounds])
#define TCT_SCREEN_SIZE                     ([[UIScreen mainScreen] bounds].size)
#define TCT_SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)
#define TCT_SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)
#define TCT_SCREEN_NONSTATUSBAR_HEIGHT      ([[UIScreen mainScreen] bounds].size.height - TCT_DEFAULT_STATUSBAR_HEIGHT)
#define TCT_IS_IPHONE_5                     ([[UIScreen mainScreen] bounds].size.height > 500.0f)

#define TCT_CHECK_VALID_STRING(x)           (x && [x isKindOfClass:[NSString class]] && [x length])
#define TCT_CHECK_VALID_NUMBER(x)           (x && [x isKindOfClass:[NSNumber class]])
#define TCT_CHECK_VALID_ARRAY(x)            (x && [x isKindOfClass:[NSArray class]] && [x count])
#define TCT_CHECK_VALID_DICTIONARY(x)       (x && [x isKindOfClass:[NSDictionary class]] && [x count])
#define TCT_CHECK_VALID_SET(x)              (x && [x isKindOfClass:[NSSet class]] && [x count])
#define TCT_CHECK_VALID_DATA(x)             (x && [x isKindOfClass:[NSData class]] && [x length])

#define TCT_CHECK_VALID_SELECTOR(d, s)      (d && [d respondsToSelector:s])

#define DEFAULT_STRING                      (@"");
#define DEFAULT_NUMBER                      ([NSNumber numberWithInteger:0]);
#define DEFAULT_ARRAY                       ([NSArray array]);
#define DEFAULT_DICTIONARY                  ([NSDictionary dictionary]);

// http://stackoverflow.com/a/5337804/822417
#define TCT_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define TCT_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define TCT_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define TCT_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define TCT_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending

#define TCT_DEVICE_IMAGE_NAME(image, suffix) ($(@"%@%@@2x%@", image, TCT_IS_IPHONE_5 ? @"-568h" : @"", suffix))
#define TCT_DEVICE_IMAGE_NAME_PNG(image) (TCT_DEVICE_IMAGE_NAME(image, @".png"))
