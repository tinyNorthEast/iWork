//
//  WGWriteBBSRequest.h
//  iWork
//
//  Created by Adele on 12/25/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGWriteBBSRequest : WGBaseRequest

- (instancetype)initWithContent:(NSString *)content toUserId:(NSNumber *)userId;

@end
