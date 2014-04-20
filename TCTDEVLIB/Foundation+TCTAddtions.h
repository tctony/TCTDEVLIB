//
//  Foundation+TCTAddtions.h
//  TCTDEVLIB
//
//  Created by Tony Tang on 14-4-17.
//  Copyright (c) 2014年 TCTONY. All rights reserved.
//


@interface NSString (TCTUrlQueryString)

+ (NSString *)tct_buildUrlString:(NSString *)urlSting params:(NSDictionary *)params;

- (NSString *)tct_urlParamKeyEncodedString;
- (NSString *)tct_urlParamValueEncodedString;

- (NSString *)tct_urlDecodedString;

@end

@interface NSData (TCTBase64)

- (NSString *)tct_base64EncodedString;

@end

@interface NSString (TCTBase64)

- (NSData *)tct_base64DecodedData;

- (NSString *)tct_base64EncodedString;
- (NSString *)tct_base64DecodedString;

@end
