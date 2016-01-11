//
//  WGProgressHUD.h
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGProgressHUD : NSObject


+ (void)defaultLoadingOnView:(UIView *)view;

+ (void)loadMessage:(NSString *)message onView:(UIView *)view;

+ (void)customImage:(UIImage *)image message:(NSString *)message onView:(UIView *)view;

+ (void)disappearSuccessMessage:(NSString *)message onView:(UIView *)view;

+ (void)disappearFailureMessage:(NSString *)message onView:(UIView *)view;

+ (void)dismissOnView:(UIView *)view;

+ (void)disappearSuccessMessage:(NSString *)message onView:(UIView *)view completBlock:(void(^)())completion;



@end
