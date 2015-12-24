//
//  WGUserInfoRequest.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGUserInfoRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGGlobal.h"

#import "WGUserInfoRequestModel.h"

@implementation WGUserInfoRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/get.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGUserInfoRequestModel alloc] initWithDictionary:data error:nil];
}

@end
