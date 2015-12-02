//
//  WGRepeatPasswordViewController.h
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,WGViewFounction) {
    WGViewFounction_SignUp = 1,
    WGViewFounction_ResetPassword = 2
};

@interface WGRepeatPasswordViewController : UIViewController

@property (nonatomic, assign)   WGViewFounction viewFounction;

@property (strong, nonatomic)   NSMutableDictionary *signUpInfoDict;
@property (nonatomic, copy)     NSString *phoneStr;

@end
