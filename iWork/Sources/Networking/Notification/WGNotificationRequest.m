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

- (instancetype)initWithType:(NSNumber *)type
{
    self = [super init];
    if (self) {
        
        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.getParams safeSetValue:type forKey:@"n_type"];
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
