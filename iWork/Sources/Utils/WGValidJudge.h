//
//  WGValidJudge.h
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGValidJudge : NSObject

+ (BOOL)isValidCGFloat:(CGFloat)afloat;

+ (BOOL)isValidInteger:(NSInteger)integer;

+ (BOOL)isValidString:(NSString *)aString;

+ (BOOL)isValidArray:(NSArray *)aArray;

+ (BOOL)isValidDictionary:(NSDictionary *)aDictionary;

+ (BOOL)isValidPhoneNum:(NSString *)phoneNum;

@end
