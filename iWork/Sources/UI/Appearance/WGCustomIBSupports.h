//
//  WGCustomIBSupports.h
//  iWork
//
//  Created by Adele on 11/23/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WGThemeColor)

@property (nonatomic, copy)   IBInspectable NSString    *wg_bgColor;
@property (nonatomic, assign) IBInspectable CGFloat     wg_bgCornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat     wg_bgCornerWidth;
@property (nonatomic, copy)   IBInspectable NSString    *wg_bgCornerColor;

@end
