//
//  TCTLogUtils.h
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//
// Usage:
//    #if DEBUG
//    #define TCT_ENABLE_LOG      1
//    #define TCT_ENABLE_ASSERT   1
//    #else
//    #define TCT_ENABLE_LOG      0
//    #define TCT_ENABLE_ASSERT   0
//    #endif
//
// Set log level:
//    [TCTLogUtils setLogLevel:kTCTLogLevelVerbose];

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


#define TCT_E(format, ...) [TCTLogUtils log:kTCTLogTypeError file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]

#if TCT_ENABLE_LOG
#define TCT_LOG(type, format, ...) [TCTLogUtils log:type file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]
#else
#define TCT_LOG(type, format, ...) EMPTY_MACRO
#endif // end of if TCT_ENABLE_LOG

#define TCT_W(format, ...) TCT_LOG(kTCTLogTypeWarn, (format), ##__VA_ARGS__)
#define TCT_I(format, ...) TCT_LOG(kTCTLogTypeInfo, (format), ##__VA_ARGS__)
#define TCT_D(format, ...) TCT_LOG(kTCTLogTypeDebug, (format), ##__VA_ARGS__)
#define TCT_V(format, ...) TCT_LOG(kTCTLogTypeVerbose, (format), ##__VA_ARGS__)

#if TCT_ENABLE_ASSERT
#define TCT_ASSERT(condition, format, ...) [TCTLogUtils assert:(condition) statement:#condition file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]
#else
#define TCT_ASSERT(condition, format, ...) [TCTLogUtils logAssert:(condition) statement:#condition file:__FILE__ line:__LINE__ method:__FUNCTION__ messageFormat:(format), ##__VA_ARGS__]
#endif // end of if TCT_ENABLE_ASSERT

#define TCT_ASSERT_MAIN_THREAD() TCT_ASSERT([NSThread isMainThread], @"current thread: %@, stacktrace: %@", [NSThread currentThread], [NSThread callStackSymbols])
#define TCT_ASSERT_NOT_MAIN_THREAD() TCT_ASSERT(![NSThread isMainThread], @"current thread: %@, stacktrace: %@", [NSThread currentThread], [NSThread callStackSymbols])

#define TCT_NS_ERROR(error) [TCTLogUtils logError:(error) recursive:YES file:__FILE__ line:__LINE__ method:(char *)__FUNCTION__]

@interface TCTLogUtils : NSObject

+ (void)setLogLevel:(TCTLogLevel)level;

+ (void)log:(TCTLogType)type
       file:(const char *)f
       line:(int)l
     method:(const char *)m
    message:(NSString *)message;

+ (void)log:(TCTLogType)type
       file:(const char *)f
       line:(int)l
     method:(const char *)m
messageFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6);


+ (void)log:(TCTLogType)type
    message:(NSString *)message;

+ (void)log:(TCTLogType)type
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

+ (void)logError:(NSError *)error
       recursive:(BOOL)recursive
            file:(const char *)f
            line:(int)l
          method:(const char *)m;

@end
