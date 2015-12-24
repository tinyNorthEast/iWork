//
//  WGDataAccess.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDataAccess.h"

#import "WGSignInModel.h"

@implementation WGDataAccess

+ (NSString *)userDefaultsStringForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (void)userDefaultsSetString:(NSString *)string forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSNumber *)userRoleForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (void)saveUserRole:(NSNumber *)role forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:role forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)industryListForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (void)industryListSetLists:(NSArray *)lists forKey:(NSString *)key;{
    [[NSUserDefaults standardUserDefaults] setObject:lists forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
