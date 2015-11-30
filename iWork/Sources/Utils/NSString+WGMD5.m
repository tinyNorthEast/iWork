//
//  NSString+WGMD5.m
//  iWork
//
//  Created by Adele on 11/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "NSString+WGMD5.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WGMD5)

+ (NSString *)stringDecodingByMD5:(NSString *)string{
    const char *cString = [string UTF8String];
    unsigned char result[32];
    
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    
    NSString *md5String = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15],
                           result[16], result[17], result[18], result[19],
                           result[20], result[21], result[22], result[23],
                           result[24], result[25], result[26], result[27],
                           result[28], result[29], result[30], result[31]
                           ];
    
    md5String = [md5String substringToIndex:32];
    return md5String;
}

@end
