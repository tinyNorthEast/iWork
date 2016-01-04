//
//  WGDeleteNotificationRequest.m
//  iWork
//
//  Created by Adele on 1/4/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGDeleteNotificationRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"

#import "WGBaseModel.h"

@implementation WGDeleteNotificationRequest

- (instancetype)initWithObjId:(NSNumber *)objId
{
    self = [super init];
    if (self) {
        
        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.getParams safeSetValue:objId forKey:@"id"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/notice/deleteNotice.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}
- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}

@end
