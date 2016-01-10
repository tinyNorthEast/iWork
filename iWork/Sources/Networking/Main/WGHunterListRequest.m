//
//  WGHunterListRequest.m
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGHunterListRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"
#import "WGHunterListModel.h"

@implementation WGHunterListRequest

- (instancetype)initWithAreaCode:(NSNumber *)areaCode industryId:(NSNumber *)industryId pageNo:(NSNumber *)pageNo
{
    self = [super init];
    if (self) {
        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.getParams safeSetValue:areaCode forKey:@"areaCode"];
        [self.getParams safeSetValue:industryId forKey:@"industryId"];
        [self.getParams safeSetValue:pageNo forKey:@"pageNo"];
        
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/headhunter/list.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGHunterListModel alloc] initWithDictionary:data error:nil];
}

@end
