//
//  WGUpdateAuthRequest.m
//  iWork
//
//  Created by Adele on 1/6/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGUpdateAuthRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGGlobal.h"

#import "WGBaseModel.h"

@implementation WGUpdateAuthRequest

- (instancetype)initWithAuthId:(NSNumber *)authId objId:(NSNumber *)objId status:(NSNumber *)stauts
{
    self = [super init];
    if (self) {
        
        [self.postParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        [self.postParams safeSetValue:authId forKey:@"authId"];
        [self.postParams safeSetValue:objId forKey:@"objId"];
        [self.postParams safeSetValue:stauts forKey:@"lt_status"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/headhunter/updateAuth.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}
- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}


@end
