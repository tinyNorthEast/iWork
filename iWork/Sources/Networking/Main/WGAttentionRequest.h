//
//  WGAttentionRequest.h
//  iWork
//
//  Created by Adele on 1/6/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGAttentionRequest : WGBaseRequest

- (instancetype)initAttention:(NSNumber *)attention toId:(NSNumber *)userId;

@end
