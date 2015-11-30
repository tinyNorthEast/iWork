//
//  WGResetPasswordRequest.h
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGResetPasswordRequest : WGBaseRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password;

@end
