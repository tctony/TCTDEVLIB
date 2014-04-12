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

