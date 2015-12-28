//
//  WGResetPasswordRequest.m
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGForgetPasswordRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "NSString+WGExtension.h"
#import "WGBaseModel.h"


@implementation WGForgetPasswordRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password
{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:phone forKey:@"phone"];
        [self.postParams safeSetValue:[[NSString stringDecodingByMD5:password] lowercaseString] forKey:@"password"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/updatePassword";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
