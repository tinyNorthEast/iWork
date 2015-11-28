//
//  WGSignUpViewController.h
//  iWork
//
//  Created by Adele on 11/20/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WGVertifyView){
    WGVertifyView_SignUp = 1,
    WGVertifyView_GetPassword
};

@interface WGVertifyPhoneViewController : UIViewController

@property (nonatomic, assign) WGVertifyView vertifyView;

@end
