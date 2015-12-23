//
//  WGHunterListRequest.h
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@class WGPager;

@interface WGHunterListRequest : WGBaseRequest

- (instancetype)initWithAreaCode:(NSString *)areaCode industryId:(NSNumber *)industryId pageNo:(NSNumber *)pageNo;

@end
