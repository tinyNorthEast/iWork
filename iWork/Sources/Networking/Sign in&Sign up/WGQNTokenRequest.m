//
//  WGQNTokenRequest.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGQNTokenRequest.h"

#import "WGQiNiuTokenModel.h"

@implementation WGQNTokenRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/qiniu/getQiniuToken.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGQiNiuTokenModel alloc] initWithDictionary:data error:nil];
}


@end
