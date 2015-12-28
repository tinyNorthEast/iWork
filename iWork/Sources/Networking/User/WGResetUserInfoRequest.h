//
//  WGResetUserInfoRequest.h
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGResetUserInfoRequest : WGBaseRequest

- (instancetype)initWithUserInfo:(NSDictionary *)info;

@end
