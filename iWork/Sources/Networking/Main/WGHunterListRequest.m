//
//  WGHunterListRequest.m
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGHunterListRequest.h"

@implementation WGHunterListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/headhunter/list";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}


@end
