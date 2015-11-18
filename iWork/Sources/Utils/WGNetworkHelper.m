//
//  WGNetworkHelper.m
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGNetworkHelper.h"

#import "AFNetworkReachabilityManager.h"

@implementation WGNetworkHelper

- (NSUInteger)networkStatus{
    AFNetworkReachabilityStatus networkStatus = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    return networkStatus;
}

@end
