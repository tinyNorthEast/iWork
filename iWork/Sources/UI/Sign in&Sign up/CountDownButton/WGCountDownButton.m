//
//  WGCountDownButton.m
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCountDownButton.h"

NSTimeInterval countDownDuration = 60;

@interface WGCountDownButton(){
    BOOL _isTimerRun;
    NSTimeInterval _currentTimeCount;
}

@property (nonatomic, copy) NSString *normalStatusTitle;

@property (nonatomic, strong) NSTimer *countDownTimer;

@property (nonatomic, strong) NSDate *lastDate;

- (void)setButtonTitleWithTimeCount:(NSTimeInterval)timeCount;

@end

@implementation WGCountDownButton

#pragma mark - Private method

- (void)setButtonTitleWithTimeCount:(NSTimeInterval)timeCount
{
    [self setTitle:[NSString stringWithFormat:@"%ldS", (long)timeCount] forState:UIControlStateNormal];
}

#pragma mark - Public method

- (BOOL)isCountDowning
{
    return _isTimerRun;
}

- (void)setButtonNormalTitle:(NSString *)title
{
    self.normalStatusTitle = title;
    if (!_isTimerRun) {
        [self setTitle:title forState:UIControlStateNormal];
    }
}

- (void)startCountDownTimer
{
    [self stopCountDownTimer];
    
    if (countDownDuration > 0) {
        self.lastDate = [NSDate date];
        _currentTimeCount = countDownDuration;
        [self setButtonTitleWithTimeCount:_currentTimeCount];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(countDownTimerHandle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
        _isTimerRun = YES;
    }
}

- (void)countDownTimerHandle
{
    if (_isTimerRun) {
        NSDate *now = [NSDate date];
        
        if ([now timeIntervalSinceDate:self.lastDate] >= 1.0) {
            _currentTimeCount--;
            [self setButtonTitleWithTimeCount:_currentTimeCount];
            self.lastDate = now;
        }
    }
    if (_currentTimeCount <= 0.0) {
        [self stopCountDownTimer];
    }
}

- (void)stopCountDownTimer
{
    if ([self.countDownTimer isValid]) {
        [self.countDownTimer invalidate];
    }
    self.countDownTimer = nil;
    _isTimerRun = NO;
    [self setTitle:self.normalStatusTitle forState:UIControlStateNormal];
}


@end
