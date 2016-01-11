//
//  WGWriteBBSRequest.m
//  iWork
//
//  Created by Adele on 12/25/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGWriteBBSRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGGlobal.h"

#import "WGBaseModel.h"

@implementation WGWriteBBSRequest

- (instancetype)initWithContent:(NSString *)content toUserId:(NSNumber *)userId objId:(NSNumber *)objId
{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:content forKey:@"content"];
        [self.postParams safeSetValue:userId forKey:@"c_to_user_id"];
        [self.postParams safeSetValue:objId forKey:@"c_main_id"];
        [self.postParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/comment/saveComment.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}

@end
