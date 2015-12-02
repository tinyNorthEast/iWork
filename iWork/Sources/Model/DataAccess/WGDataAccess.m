//
//  WGDataAccess.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDataAccess.h"

@implementation WGDataAccess

+ (NSString *)userDefaultsStringForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (void)userDefaultsSetString:(NSString *)string forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
}

@end
