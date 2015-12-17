//
//  WGHunterDetailRequest.h
//  iWork
//
//  Created by Adele on 12/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGHunterDetailRequest : WGBaseRequest

- (instancetype)initWithHunterId:(NSNumber *)hunterId;

@end
