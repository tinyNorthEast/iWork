//
//  WGQNTokenRequest.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGQNTokenRequest.h"

#import "WGBaseModel.h"

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
    return @"api/v1/qiniu/getQiniuToken";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
