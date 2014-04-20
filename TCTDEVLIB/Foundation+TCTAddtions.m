//
//  Foundation+TCTAddtions.m
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-17.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//

#import "Foundation+TCTAddtions.h"

@implementation NSString (TCTUrlQueryString)

+ (NSString *)tct_buildUrlString:(NSString *)urlSting params:(NSDictionary *)params
{
    if (urlSting == nil) {
        urlSting = @"";
    }
    
    if (![urlSting isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSMutableString *resultString = [NSMutableString stringWithString:urlSting];
    if (params && [params isKindOfClass:[NSDictionary class]] && [params count]) {
        NSString *anchor = @"";
        
        if ([urlSting length]) {
            NSUInteger index = [resultString rangeOfString:@"#"].location;
            
            if (index != NSNotFound) {
                anchor = [resultString substringFromIndex:index];
                [resultString deleteCharactersInRange:NSMakeRange(index, resultString.length - index)];
            }
            
            index = [resultString rangeOfString:@"?"].location;
            if (index == NSNotFound) {
                [resultString appendString:@"?"];
            }
            else if (index < resultString.length-1) {
                [resultString appendString:@"&"];
            }
        }
        
        NSMutableArray *pairArray = [NSMutableArray arrayWithCapacity:[params count]];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isKindOfClass:[NSString class]]) {
                NSString *value = nil;
                
                if ([obj isKindOfClass:[NSString class]]) {
                    value = obj;
                }
                else if ([obj isKindOfClass:[NSNumber class]]) {
                    value = [obj stringValue];
                }
                else if (([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]])
                         && [NSJSONSerialization isValidJSONObject:obj]) {
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
                    value = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                }
                else if ([obj isKindOfClass:[NSData class]]) {
                    value = [obj tct_base64EncodedString];
                }
                else {
                    value = [obj description];
                }
                
                [pairArray addObject:[NSString stringWithFormat:@"%@=%@", [key tct_urlParamKeyEncodedString], [value tct_urlParamValueEncodedString]]];
            }
        }];
        [resultString appendString:[pairArray componentsJoinedByString:@"&"]];
        
        [resultString appendString:anchor];
    }
    return [NSString stringWithString:resultString];
}

// http://en.wikipedia.org/wiki/Percent-encoding#Percent-encoding_reserved_characters
static NSString * const kTCTCharactersToBeEscapedInQueryStringParam = @"!#$&'()*+,/:;=?@[]";
static NSString * const kTCTCharactersToLeaveUnescapedInQueryStringParamKey = @"[]";

- (NSString *)tct_urlParamKeyEncodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, (__bridge CFStringRef)kTCTCharactersToLeaveUnescapedInQueryStringParamKey, (__bridge CFStringRef)kTCTCharactersToBeEscapedInQueryStringParam, kCFStringEncodingUTF8);
}

- (NSString *)tct_urlParamValueEncodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)kTCTCharactersToBeEscapedInQueryStringParam, kCFStringEncodingUTF8);
}

- (NSString *)tct_urlDecodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR(""));
}

@end

// http://www.faqs.org/rfcs/rfc2045.html 6.8
static uint8_t const kTCTBase64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
// http://stackoverflow.com/a/4727124/822417
// http://en.wikipedia.org/wiki/ASCII
// http://en.wikipedia.org/wiki/Whitespace_character
// acceptable whilespace: 0x09(HT,\t), 0x0A(LF,NL,\n), 0x0C(FF,\f), 0x0D(CR,\r), 0x20(SPACE)
static int8_t const kTCTBase64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
};

@implementation NSData (TCTBase64)

- (NSString *)tct_base64EncodedString
{
    NSUInteger length = [self length];
    NSMutableData *encodedData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[self bytes];
    uint8_t *output = (uint8_t *)[encodedData mutableBytes];
    
    for (NSUInteger i=0; i<length; i+=3) {
        NSUInteger value = 0;
        for (NSUInteger j=i; j<i+3; ++j) {
            value <<= 8;
            if (j <length) {
                value |= input[j];
            }
        }
        
        NSUInteger k = (i / 3) * 4;
        output[k + 0] = kTCTBase64EncodingTable[(value >> 18) & 0x3F];
        output[k + 1] = kTCTBase64EncodingTable[(value >> 12) & 0x3F];
        output[k + 2] = (i + 1) < length ? kTCTBase64EncodingTable[(value >> 6) & 0x3F] : '=';
        output[k + 3] = (i + 2) < length ? kTCTBase64EncodingTable[(value >> 0) & 0x3F] : '=';
    }

    return [[NSString alloc] initWithData:encodedData encoding:NSASCIIStringEncoding];
}

@end

@implementation NSString (TCTBase64)

- (NSData *)tct_base64DecodedData
{
    NSData *encodedData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSUInteger length = [encodedData length];

    NSMutableData *decodedData = [NSMutableData data];
    
    uint8_t *input = (uint8_t *)[encodedData bytes];

    uint8_t ch, inbuf[4], outbuf[3];

    NSUInteger index = 0;
    NSUInteger count = 0;
    
    while (index < length) {
        ch = input[index++];
        char v = kTCTBase64DecodingTable[ch];
        if (v>=0 || ch == '=') {
            inbuf[count++] = ch;
        }
        else if (v == -1) {
            continue;
        }
        else if (v == -2) {
            return  nil;
        }
        
        if (count == 4) {
            if (inbuf[0] == '=' || inbuf[1] == '=') {
                return nil;
            }
            
            if (inbuf[2] != '=' && inbuf[3] != '=') {
                count = 3;
            }
            else if (inbuf[2] != '=' && inbuf[3] == '=') {
                count = 2;
            }
            else if (inbuf[2] == '=' && inbuf[3] == '=') {
                count = 1;
            }
            else {
                return nil;
            }
            
            outbuf[0] = ((kTCTBase64DecodingTable[inbuf[0]] & 0x3F) << 2) | ((kTCTBase64DecodingTable[inbuf[1]] & 0x30) >> 4);
            if (count > 1) {
                outbuf[1] = ((kTCTBase64DecodingTable[inbuf[1]] & 0x0F) << 4) | ((kTCTBase64DecodingTable[inbuf[2]] & 0x3C) >> 2);
            }
            if (count > 2) {
                outbuf[2] = ((kTCTBase64DecodingTable[inbuf[2]] & 0x03) << 6) | ((kTCTBase64DecodingTable[inbuf[3]] & 0x3F) >> 0);
            }
            
            [decodedData appendBytes:outbuf length:count];
            
            if (count != 3) {
                count = 0;
                break;
            }
            
            count = 0;
        }
    }
    
    if (index != length || count != 0) {
        return nil;
    }
    
    return [NSData dataWithData:decodedData];
}

- (NSString *)tct_base64EncodedString
{
    NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [stringData tct_base64EncodedString];
}

- (NSString *)tct_base64DecodedString
{
    NSData *decodedData = [self tct_base64DecodedData];
    if (decodedData != nil) {
        return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
