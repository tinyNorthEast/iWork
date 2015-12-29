//
//  WGCodeRequest.m
//  iWork
//
//  Created by Adele on 12/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCodeRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"
#import "WGCodeListModel.h"

@implementation WGCodeRequest

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
    return @"api/v1/invate/getInvates.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGCodeListModel alloc] initWithDictionary:data error:nil];
}

@end
