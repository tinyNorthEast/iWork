//
//  WGCountDownButton.h
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGCountDownButton : UIButton

@property (nonatomic, readonly) BOOL isCountDowning;

- (void)setButtonNormalTitle:(NSString *)title;

- (void)startCountDownTimer;

- (void)stopCountDownTimer;

@end
