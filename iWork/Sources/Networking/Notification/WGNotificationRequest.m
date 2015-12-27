//
//  WGNotificationRequest.m
//  iWork
//
//  Created by Adele on 12/26/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGNotificationRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"
#import "WGBaseModel.h"

@implementation WGNotificationRequest

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
    return @"api/v1/notice/findNoticeList.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}
- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
