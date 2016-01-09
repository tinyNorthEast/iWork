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

+ (instancetype)wg_themeBlackColor{
    return [UIColor colorWithHex:0x333333];
}
+ (instancetype)wg_themeDarkGrayColor{
    return [UIColor colorWithHex:0x666666];
}

+ (instancetype)wg_themeGrayColor{
    return [UIColor colorWithHex:0x999999];
}

+ (instancetype)wg_themeLightGrayColor{
    return [UIColor colorWithHex:0xAAAAAA];
}

+ (instancetype)wg_themeMoreLightGrayColor{
    return [UIColor colorWithHex:0xCCCCCC];
}

+ (instancetype)wg_themeDarkWhiteColor{
    return [UIColor colorWithHex:0xF3F3F3];
}

+ (instancetype)wg_themeWhiteColor{
    return [UIColor colorWithHex:0xFFFFFF];
}

+ (instancetype)wg_themeCyanColor{
    return [UIColor colorWithHex:0x11AAAA];
}

+ (instancetype)wg_themeGreenColor{
    return [UIColor colorWithHex:0x66BB22];
}

+ (instancetype)wg_themeYellowColor{
    return [UIColor colorWithHex:0xDAA116];
}
+ (instancetype)wg_themeColorFromSelectorString:(NSString *)string{
    if (![WGValidJudge isValidString:string]) {
        return nil;
    }
    
    return [UIColor colorWithCSS:string];
}


+ (UIColor *)messagesBackgroundColor
{
    return [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
}

+ (UIColor *)messagesTimestampColor
{
    return [UIColor colorWithRed:0.533f green:0.573f blue:0.647f alpha:1.0f];
}
@end
