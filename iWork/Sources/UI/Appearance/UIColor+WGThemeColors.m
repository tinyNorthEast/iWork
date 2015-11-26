//
//  UIColor+WGThemeColors.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "UIColor+WGThemeColors.h"

#import <UIColor+Hex.h>
#import "WGValidJudge.h"

@implementation UIColor (WGThemeColors)

+ (instancetype)wg_themeRedColor{
    return [UIColor colorWithHex:0xF16B50];
}
+ (instancetype)wg_themeColorFromSelectorString:(NSString *)string{
    if (![WGValidJudge isValidString:string]) {
        return nil;
    }
    
    return [UIColor colorWithCSS:string];
}
@end
