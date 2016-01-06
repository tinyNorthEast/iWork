//
//  WGAttentionRequest.m
//  iWork
//
//  Created by Adele on 1/6/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGAttentionRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGGlobal.h"

#import "WGBaseModel.h"

@implementation WGAttentionRequest

- (instancetype)initAttention:(NSNumber *)attention toId:(NSNumber *)userId
{
    self = [super init];
    if (self) {
        
        [self.postParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.postParams safeSetValue:attention forKey:@"isAttention"];
        [self.postParams safeSetValue:userId forKey:@"attention_to_id"];
        
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/attention/saveAttention.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
