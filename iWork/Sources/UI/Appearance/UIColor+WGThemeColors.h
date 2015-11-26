//
//  UIColor+WGThemeColors.h
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WGThemeColors)

+ (instancetype)wg_themeRedColor;

+ (instancetype)wg_themeColorFromSelectorString:(NSString *)string;

@end
