//
//  WGSignInRequest.h
//  iWork
//
//  Created by Adele on 11/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

@interface WGSignInRequest : WGBaseRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password;

@end
