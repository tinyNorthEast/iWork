//
//  WGDataAccess.h
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGDataAccess : NSObject

+ (NSString *)userDefaultsStringForKey:(NSString *)key;
+ (void)userDefaultsSetString:(NSString *)string forKey:(NSString *)key;

+ (NSArray *)industryListForKey:(NSString *)key;
+ (void)industryListSetLists:(NSArray *)lists forKey:(NSString *)key;

@end
