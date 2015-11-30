//
//  WGResetPasswordRequest.m
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetPasswordRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "NSString+WGMD5.h"
#import "WGBaseModel.h"


@implementation WGResetPasswordRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password
{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:phone forKey:@"phone"];
        [self.postParams safeSetValue:[[NSString stringDecodingByMD5:password] lowercaseString] forKey:@"password"];
        
        [self.postParams safeSetValue:@"2" forKey:@"client"];
        [self.postParams safeSetValue:@"123456" forKey:@"eq_num"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
