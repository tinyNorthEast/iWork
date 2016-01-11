//
//  WGResetUserInfoRequest.m
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetUserInfoRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGBaseModel.h"
#import "WGGlobal.h"

@implementation WGResetUserInfoRequest

- (instancetype)initWithUserInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        
        [self.postParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.postParams safeSetValue:info[@"zh_name"] forKey:@"zh_name"];
        [self.postParams safeSetValue:info[@"password"] forKey:@"password"];
        [self.postParams safeSetValue:info[@"mail"] forKey:@"mail"];
        [self.postParams safeSetValue:info[@"en_name"] forKey:@"en_name"];
        [self.postParams safeSetValue:info[@"company"] forKey:@"company"];
        [self.postParams safeSetValue:info[@"experience"] forKey:@"experience"];
        [self.postParams safeSetValue:info[@"pic"] forKey:@"pic"];
        
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/update.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
