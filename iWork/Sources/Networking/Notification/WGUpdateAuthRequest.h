//
//  WGUpdateAuthRequest.h
//  iWork
//
//  Created by Adele on 1/6/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGUpdateAuthRequest : WGBaseRequest

- (instancetype)initWithAuthId:(NSNumber *)authId status:(NSNumber *)stauts;

@end
