//
//  NSString+WGMD5.h
//  iWork
//
//  Created by Adele on 11/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WGMD5)

+ (NSString *)stringDecodingByMD5:(NSString *)string;

@end
