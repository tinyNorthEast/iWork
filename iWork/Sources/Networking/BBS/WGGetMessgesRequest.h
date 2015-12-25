//
//  WGMessgesRequest.h
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGGetMessgesRequest : WGBaseRequest

- (instancetype)initWithToUserId:(NSNumber *)userId;

@end
