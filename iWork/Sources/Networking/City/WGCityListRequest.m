//
//  WGCityListRequest.m
//  iWork
//
//  Created by Adele on 12/4/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCityListRequest.h"

#import "WGCityListModel.h"

@implementation WGCityListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/city/findCityList.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGCityListModel alloc] initWithDictionary:data error:nil];
}

@end
