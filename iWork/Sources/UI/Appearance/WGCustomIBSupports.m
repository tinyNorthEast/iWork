//
//  WGCustomIBSupports.m
//  iWork
//
//  Created by Adele on 11/23/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCustomIBSupports.h"

#import "WGValidJudge.h"
#import "UIColor+WGThemeColors.h"

@implementation UIView(WGThemeColor)
@dynamic wg_bgColor,wg_bgCornerRadius,wg_bgCornerWidth,wg_bgCornerColor;

- (void)setWg_bgColor:(NSString *)wg_bgColor{
    UIColor *color = [UIColor wg_themeColorFromSelectorString:wg_bgColor];
    if (color) {
        self.backgroundColor = color;
    }
}

- (void)setWg_bgCornerRadius:(CGFloat)wg_bgCornerRadius{
    if ([WGValidJudge isValidInteger:wg_bgCornerRadius]){
        self.layer.cornerRadius = wg_bgCornerRadius;
        self.layer.masksToBounds = YES;
    }
}

- (void)setWg_bgCornerWidth:(CGFloat)wg_bgCornerWidth{
    if ([WGValidJudge isValidCGFloat:wg_bgCornerWidth]) {
        self.layer.borderWidth = wg_bgCornerWidth;
    }
}

- (void)setWg_bgCornerColor:(NSString *)wg_bgCornerColor{
    if ([WGValidJudge isValidString:wg_bgCornerColor]) {
        UIColor *color = [UIColor wg_themeColorFromSelectorString:wg_bgCornerColor];
        if (color) {
            self.layer.borderColor = color.CGColor;
        }
    }
}

@end
