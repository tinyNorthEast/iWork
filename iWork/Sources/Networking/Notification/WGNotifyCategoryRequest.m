//
//  WGNotifyCategoryRequest.m
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGNotifyCategoryRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"

#import "WGNotifiCategoryListModel.h"

@implementation WGNotifyCategoryRequest

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
    return @"api/v1/notice/findGroupNoticeCount.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}
- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGNotifiCategoryListModel alloc] initWithDictionary:data error:nil];
}

@end
