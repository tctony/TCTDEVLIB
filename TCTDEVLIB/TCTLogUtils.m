//
//  TCTLogUtils.m
//  TCTDEVLIB
//
//  Created by changtang on 3/27/14.
//  Copyright (c) 2014 TCTONY. All rights reserved.
//

#import "TCTLogUtils.h"

CG_INLINE NSString *tct_logLevelString(TCTLogLevel level)
{
    NSString *levelString = @"";
    switch (level) {
        case kTCTLogLevelVerbose:
            levelString = @"V";
            break;
        case kTCTLogLevelDebug:
            levelString = @"D";
            break;
        case kTCTLogLevelInfo:
            levelString = @"I";
            break;
        case kTCTLogLevelWarn:
            levelString = @"W";
            break;
        case kTCTLogLevelError:
            levelString = @"E";
            break;
        default:
            NSLog(@"unknown log level");
            break;
    }
    return levelString;
}

CG_INLINE NSString *tct_logShortPath(const char *path)
{
    if (!path) { return @""; }
    return [[[NSString alloc] initWithBytes:path length:strlen(path) encoding:NSUTF8StringEncoding] lastPathComponent];
}

@interface TCTLogUtils ()

@end

@implementation TCTLogUtils

+ (void)log:(TCTLogLevel)level message:(NSString *)message
{
    NSLog(@"[%@]: %@", tct_logLevelString(level), message);
}

+ (void)log:(TCTLogLevel)level messageFormat:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);
    NSString *formatString = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [TCTLogUtils log:level message:formatString];
}

+ (void)log:(TCTLogLevel)level file:(const char *)f line:(int)l method:(const char *)m message:(NSString *)message
{
     NSLog(@"[%@] *%@:%d %s: %@", tct_logLevelString(level), tct_logShortPath(f), l, m, message);
}

+ (void)log:(TCTLogLevel)level file:(const char *)f line:(int)l method:(const char *)m messageFormat:(NSString *)format, ...
{
    va_list argList;
    va_start(argList, format);
    NSString *formatString = [[NSString alloc] initWithFormat:format arguments:argList];
    va_end(argList);
    
    [TCTLogUtils log:level file:f line:l method:m message:formatString];
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

        [TCTLogUtils log:kTCTLogLevelError messageFormat:@"Assertion failed: %s", statement];
        [TCTLogUtils log:kTCTLogLevelError file:f line:l method:m message:formatString];
        [TCTLogUtils log:kTCTLogLevelError messageFormat:@"Callstack: %@", [NSThread callStackSymbols]];
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
        
        [TCTLogUtils log:kTCTLogLevelError message:message];
    }
}

@end
