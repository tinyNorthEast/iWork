//
//  WGSignInRequest.m
//  iWork
//
//  Created by Adele on 11/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignInRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "NSString+WGMD5.h"
#import "WGBaseModel.h"
#import "UIDevice+WGIdentifier.h"

@implementation WGSignInRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password
{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:phone forKey:@"phone"];
        [self.postParams safeSetValue:[[NSString stringDecodingByMD5:password] lowercaseString] forKey:@"password"];
        
        [self.postParams safeSetValue:@"2" forKey:@"client"];
        [self.postParams safeSetValue:[[UIDevice currentDevice] UniqueGlobalDeviceIdentifier] forKey:@"eq_num"];
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/login.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}

@end
