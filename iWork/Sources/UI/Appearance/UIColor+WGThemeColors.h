//
//  UIColor+WGThemeColors.h
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WGThemeColors)

+ (instancetype)wg_themeBlackColor;

+ (instancetype)wg_themeDarkGrayColor;

+ (instancetype)wg_themeGrayColor;

+ (instancetype)wg_themeLightGrayColor;

+ (instancetype)wg_themeDarkWhiteColor;

+ (instancetype)wg_themeWhiteColor;

+ (instancetype)wg_themeCyanColor;

+ (instancetype)wg_themeGreenColor;

+ (instancetype)wg_themeYellowColor;

+ (instancetype)wg_themeColorFromSelectorString:(NSString *)string;

@end
