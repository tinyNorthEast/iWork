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
#import "WGNotificationListModel.h"

@implementation WGNotificationRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.getParams safeSetValue:@"8108aa66226b0d699dd1cb4a01419db2" forKey:@"token"];
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
    return [[WGNotificationListModel alloc] initWithDictionary:data error:nil];
}


@end
