//
//  WGHunterDetailRequest.m
//  iWork
//
//  Created by Adele on 12/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGHunterDetailRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGDataAccess.h"
#import "SignHeader.h"

#import "WGHunterDetailModel.h"

@implementation WGHunterDetailRequest

- (instancetype)initWithHunterId:(NSNumber *)hunterId{
    self = [super init];
    if (self) {
        
        [self.getParams safeSetValue:hunterId forKey:@"headhunterId"];
        [self.getParams safeSetValue:[WGDataAccess userDefaultsStringForKey:kUSERTOKEN_KEY] forKey:@"token"];
        
        return self;
    }
    return nil;
}
- (NSString *)pathName{
    return @"api/v1/headhunter/detail.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGHunterDetailModel alloc] initWithDictionary:data error:nil];
}

@end