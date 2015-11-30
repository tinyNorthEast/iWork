//
//  WGProgressHUD.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGProgressHUD.h"

#import "MBProgressHUD.h"


static NSInteger timeInterval = 1.5;

@implementation WGProgressHUD


+ (MBProgressHUD *)initHUDonView:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    return HUD;
}
+ (void)defaultLoadingOnView:(UIView *)view{
    [self dismissOnView:view];
    MBProgressHUD *HUD = [self initHUDonView:view];
    
    [view addSubview:HUD];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
}

+ (void)loadMessage:(NSString *)message onView:(UIView *)view{
    [self dismissOnView:view];
    MBProgressHUD *HUD = [self initHUDonView:view];
    
    [view addSubview:HUD];
    HUD.labelText = message;
    [HUD show:YES];
}

+ (void)customImage:(UIImage *)image message:(NSString *)message onView:(UIView *)view{
    [self dismissOnView:view];
    MBProgressHUD *HUD = [self initHUDonView:view];
    
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.labelText = message;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD show:YES];
}

+ (void)disappearSuccessMessage:(NSString *)message onView:(UIView *)view{
    [self dismissOnView:view];
    MBProgressHUD *HUD = [self initHUDonView:view];
    
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:timeInterval];
}

+ (void)disappearFailureMessage:(NSString *)message onView:(UIView *)view{
    [self dismissOnView:view];
    MBProgressHUD *HUD = [self initHUDonView:view];
    
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_failed"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:timeInterval];
}

+ (void)dismissOnView:(UIView *)view{
    if (!view) {
        return;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
