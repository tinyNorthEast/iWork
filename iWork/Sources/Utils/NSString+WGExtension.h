//
//  NSString+WGMD5.h
//  iWork
//
//  Created by Adele on 11/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WGExtension)

+ (NSString *)stringDecodingByMD5:(NSString *)string;

+ (BOOL)isValidEmail:(NSString *)checkString;

@end
