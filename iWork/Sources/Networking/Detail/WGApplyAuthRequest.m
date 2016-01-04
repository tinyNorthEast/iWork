//
//  WGApplyAuthRequest.m
//  iWork
//
//  Created by Adele on 1/3/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGApplyAuthRequest.h"

#import "NSMutableDictionary+WGExtension.h"

#import "WGGlobal.h"
#import "WGBaseModel.h"

@implementation WGApplyAuthRequest

- (instancetype)initWithHunterId:(NSNumber *)hunterId hr_mail:(NSString *)mail{
    self = [super init];
    if (self) {
        
        [self.postParams safeSetValue:hunterId forKey:@"headhunterId"];
        [self.postParams safeSetValue:[[WGGlobal sharedInstance]userToken] forKey:@"token"];
        [self.postParams safeSetValue:mail forKey:@"hr_mail"];
        
        return self;
    }
    return nil;
}
- (NSString *)pathName{
    return @"api/v1/headhunter/saveHeadhunterAuth.action ";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}

@end
