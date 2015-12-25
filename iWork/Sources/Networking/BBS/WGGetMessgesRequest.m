//
//  WGMessgesRequest.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGGetMessgesRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"
#import "WGBBSListModel.h"

@implementation WGGetMessgesRequest

- (instancetype)initWithToUserId:(NSNumber *)userId
{
    self = [super init];
    if (self) {
        [self.getParams safeSetValue:userId forKey:@"to_user_id"];
        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/comment/findCommentList.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBBSListModel alloc] initWithDictionary:data error:nil];
}

@end
