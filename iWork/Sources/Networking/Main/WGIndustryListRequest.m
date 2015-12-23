//
//  WGIndustryListRequest.m
//  iWork
//
//  Created by Adele on 12/23/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGIndustryListRequest.h"

#import "WGMainIndustryListModel.h"

@implementation WGIndustryListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/industry/findIndustryList.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGMainIndustryListModel alloc] initWithDictionary:data error:nil];
}


@end
