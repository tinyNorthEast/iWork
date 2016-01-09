//
//  WGVertifyPhoneRequest.m
//  iWork
//
//  Created by Adele on 1/7/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGVertifyPhoneRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGBaseModel.h"

@implementation WGVertifyPhoneRequest

- (instancetype)initWithPhoneNum:(NSString *)phone
{
    self = [super init];
    if (self) {
        [self.getParams safeSetValue:phone forKey:@"phone"];

        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/phone.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
