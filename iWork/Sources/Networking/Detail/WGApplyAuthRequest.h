//
//  WGApplyAuthRequest.h
//  iWork
//
//  Created by Adele on 1/3/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGApplyAuthRequest : WGBaseRequest

- (instancetype)initWithHunterId:(NSNumber *)hunterId hr_mail:(NSString *)mail;

@end
