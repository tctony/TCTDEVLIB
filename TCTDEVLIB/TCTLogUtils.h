//
//  TCTLogUtils.h
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, TCTLogType) {
    kTCTLogTypeError    = 1 << 0,
    kTCTLogTypeWarn     = 1 << 1,
    kTCTLogTypeInfo     = 1 << 2,
    kTCTLogTypeDebug    = 1 << 3,
    kTCTLogTypeVerbose  = 1 << 4,
};

typedef NS_OPTIONS(NSInteger, TCTLogLevel) {
    kTCTLogLevelError   = kTCTLogTypeError,
    kTCTLogLevelWarn    = kTCTLogTypeWarn | kTCTLogLevelError,
    kTCTLogLevelInfo    = kTCTLogTypeInfo | kTCTLogLevelWarn,
    kTCTLogLevelDebug   = kTCTLogTypeDebug | kTCTLogLevelInfo,
    kTCTLogLevelVerbose = kTCTLogTypeVerbose | kTCTLogLevelDebug,
};


#define TCT_E(format, ...) [TCTLogUtils log:kTCTLogLevelError file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]

#if TCT_ENABLE_LOG
#define TCT_LOG(level, format, ...) [TCTLogUtils log:level file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]
#else
#define TCT_LOG(level, format, ...) EMPTY_MACRO
#endif // end of if TCT_ENABLE_LOG

#define TCT_W(format, ...) TCT_LOG(kTCTLogLevelWarn, (format), ##__VA_ARGS__)
#define TCT_I(format, ...) TCT_LOG(kTCTLogLevelInfo, (format), ##__VA_ARGS__)
#define TCT_D(format, ...) TCT_LOG(kTCTLogLevelDebug, (format), ##__VA_ARGS__)
#define TCT_V(format, ...) TCT_LOG(kTCTLogLevelVerbose, (format), ##__VA_ARGS__)

#if TCT_ENABLE_ASSERT
#define TCT_ASSERT(condition, format, ...) [TCTLogUtils assert:(condition) statement:#condition file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]
#else
#define TCT_ASSERT(condition, format, ...) [TCTLogUtils logAssert:(condition) statement:#condition file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]
#endif // end of if TCT_ENABLE_ASSERT

#define TCT_NS_ERROR(error) [TCTLogUtils logError:(error) recursive:YES file:__FILE__ line:__LINE__ method:(char *)__FUNCTION__]

@interface TCTLogUtils : NSObject

+ (void)log:(TCTLogLevel)level
       file:(const char *)f
       line:(int)l
     method:(const char *)m
    message:(NSString *)message;

+ (void)log:(TCTLogLevel)level
       file:(const char *)f
       line:(int)l
     method:(const char *)m
messageFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6);


+ (void)log:(TCTLogLevel)level
    message:(NSString *)message;

+ (void)log:(TCTLogLevel)level
messageFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(2, 3);

+ (void)assert:(BOOL)condition
     statement:(const char *)statement
          file:(const char *)f
          line:(int)l
        method:(const char *)m
 messageFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(6, 7);

+ (void)logAssert:(BOOL)condition
        statement:(const char *)statement
             file:(const char *)f
             line:(int)l
           method:(const char *)m
    messageFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(6, 7);

+ (void)logError:(NSError *)error recursive:(BOOL)recursive file:(const char *)f line:(int)l method:(const char *)m;

@end