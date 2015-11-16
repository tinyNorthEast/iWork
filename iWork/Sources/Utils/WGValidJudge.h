//
//  WGValidJudge.h
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGValidJudge : NSObject

+ (BOOL)isValidString:(NSString *)aString;

+ (BOOL)isValidArray:(NSArray *)aArray;

+ (BOOL)isValidDictionary:(NSDictionary *)aDictionary;

@end
