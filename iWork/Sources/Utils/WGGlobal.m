//
//  WGGlobal.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGGlobal.h"

#import "WGDataAccess.h"

#define kUserTokenKey @"usertoken"

@implementation WGGlobal

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(WGGlobal)

- (NSString *)userToken
{
    if (_userToken == nil)
    {
        _userToken = [WGDataAccess userDefaultsStringForKey:kUserTokenKey];
    }
    return _userToken;
}

- (void)saveToken:(NSString *)token
{
    [WGDataAccess userDefaultsSetString:token forKey:kUserTokenKey];
    _userToken = token;
}

- (void)clearToken
{
    [WGDataAccess userDefaultsSetString:nil forKey:kUserTokenKey];
    _userToken = nil;
}


@end
