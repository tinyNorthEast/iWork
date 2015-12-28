//
//  WGResetPasswordRequest.m
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetPasswordRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGBaseModel.h"
#import "WGGlobal.h"

@implementation WGResetPasswordRequest

- (instancetype)initWithOldPassword:(NSString *)oldPsw newPassword:(NSString *)newPsw
{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:oldPsw forKey:@"phone"];
        //        [self.postParams safeSetValue:[[NSString stringDecodingByMD5:[[WGGlobal sharedInstance] userToken]] lowercaseString] forKey:@"password"];
        [self.postParams safeSetValue:newPsw forKey:@"password"];
        [self.postParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/updatePassword.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
