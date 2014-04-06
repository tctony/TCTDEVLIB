//
//  TCTLogUtils.m
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

#import "TCTLogUtils.h"

static inline NSString *tct_logTypeString(TCTLogType type)
{
    NSString *typeString = @"";
    switch (type) {
        case kTCTLogTypeVerbose:
            typeString = @"V";
            break;
        case kTCTLogTypeDebug:
            typeString = @"D";
            break;
        case kTCTLogTypeInfo:
            typeString = @"I";
            break;
        case kTCTLogTypeWarn:
            typeString = @"W";
            break;
        case kTCTLogTypeError:
            typeString = @"E";
            break;
        default:
            NSLog(@"unknown log type");
            break;
    }
    return typeString;
}

static inline NSString *tct_logShortPath(const char *path)
{
    if (!path) { return @""; }
    return [[[NSString alloc] initWithBytes:path length:strlen(path) encoding:NSUTF8StringEncoding] lastPathComponent];
}

static TCTLogLevel logLevel = kTCTLogLevelVerbose;

@interface TCTLogUtils ()

@end

@implementation TCTLogUtils

+ (void)setLogLevel:(TCTLogLevel)level
{
    logLevel = level;
}

+ (void)log:(TCTLogType)type message:(NSString *)message
{
    if (logLevel & type) {
        NSLog(@"[%@]: %@", tct_logTypeString(type), message);
    }
}

+ (void)log:(TCTLogType)type messageFormat:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);
    NSString *formatString = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [TCTLogUtils log:type message:formatString];
}

+ (void)log:(TCTLogType)type file:(const char *)f line:(int)l method:(const char *)m message:(NSString *)message
{
    if (logLevel & type) {
        NSLog(@"[%@] *%@:%d %s: %@", tct_logTypeString(type), tct_logShortPath(f), l, m, message);
    }
}

+ (void)log:(TCTLogType)type file:(const char *)f line:(int)l method:(const char *)m messageFormat:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);
    NSString *formatString = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [TCTLogUtils log:type file:f line:l method:m message:formatString];
}


+ (void)assert:(BOOL)condition statement:(const char *)statement file:(const char *)f line:(int)l method:(const char *)m messageFormat:(NSString *)format, ...
{
    if (!condition) {
        va_list argList;
        va_start(argList, format);
        NSString *formatString = [[NSString alloc] initWithFormat:format arguments:argList];
        va_end(argList);
        
        NSString *fullMessage = [[NSString alloc] initWithFormat:@"\n\tAssertion failed: %s\n\t*%@:%d %s, %@", statement, tct_logShortPath(f), l, m, formatString];
        NSAssert(condition, fullMessage);
    }
}

+ (void)logAssert:(BOOL)condition statement:(const char *)statement file:(const char *)f line:(int)l method:(const char *)m messageFormat:(NSString *)format, ...
{
    if (!condition) {
        va_list argList;
        va_start(argList, format);
        NSString *formatString = [[NSString alloc] initWithFormat:format arguments:argList];
        va_end(argList);

        [TCTLogUtils log:kTCTLogTypeError messageFormat:@"Assertion failed: %s", statement];
        [TCTLogUtils log:kTCTLogTypeError file:f line:l method:m message:formatString];
        [TCTLogUtils log:kTCTLogTypeError messageFormat:@"Callstack: %@", [NSThread callStackSymbols]];
    }
}

+ (void)logError:(NSError *)error recursive:(BOOL)recursive file:(const char *)f line:(int)l method:(const char *)m
{
    if (error) {
        NSMutableString *message = [[NSMutableString alloc] init];
        
        [message appendFormat:@"NS_ERROR!! %@ %@", [error localizedDescription], [error localizedFailureReason]];
        
        if (recursive) {
            while (error) {
                error = [[error userInfo] objectForKey:NSUnderlyingErrorKey];
                if (error) {
                    [message appendFormat:@"\n\t %@ %@", [error localizedDescription], [error localizedFailureReason]];
                }
            }
        }
        
        [TCTLogUtils log:kTCTLogTypeError message:message];
    }
}

@end
