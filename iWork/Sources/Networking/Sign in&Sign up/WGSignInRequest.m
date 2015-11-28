//
//  WGSignInRequest.m
//  iWork
//
//  Created by Adele on 11/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignInRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGBaseModel.h"

@implementation WGSignInRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password
{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:phone forKey:@"phone"];
        [self.postParams safeSetValue:password forKey:@"password"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/login.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}

@end
