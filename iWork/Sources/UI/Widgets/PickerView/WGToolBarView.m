//
//  WGToolBarView.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGToolBarView.h"

#import "UIViewAdditions.h"

#import "UIColor+WGThemeColors.h"

@interface WGToolBarView(){
    float _xPadding;
}
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation WGToolBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor wg_themeLightGrayColor];
        
        [self setupView];
    }
    return self;
}

- (void)setupView{
    //分割线
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-0.5, SCREEN_WIDTH, 0.5)];
//    lineLabel.backgroundColor = [UIColor kColorGray1];
//    [self addSubview:lineLabel];
//    
    _xPadding = 8;
    //取消按钮
    [self addSubview:self.cancelButton];
    //确定按钮
    [self addSubview:self.confirmButton];
    //标题
    [self addSubview:self.titleLabel];
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancelButton setTitleColor:[UIColor kColorLightBlack] forState:UIControlStateNormal];
//        _cancelButton.titleLabel.font = [UIFont kFontSizeLarge];
        [_cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelButton.frame = CGRectMake(_xPadding, 0, 60, 40);
        _cancelButton.centerY = self.centerY;
    }
    return _cancelButton;
}
- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
//        _confirmButton.titleLabel.font = [UIFont kFontSizeLarge];
//        [_confirmButton setTitleColor:[UIColor kColorGray] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmPressed:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.frame = CGRectMake(0, 0, 60, 40);
        _confirmButton.right = self.width - _xPadding;
        _confirmButton.centerY = self.centerY;
    }
    return _confirmButton;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
        _titleLabel.centerY = self.centerY;
        _titleLabel.centerX = self.width/2;
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
//        _titleLabel.font=[UIFont kFontSizeLarge];
        _titleLabel.textColor=[UIColor wg_themeWhiteColor];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

#pragma mark - IBAction
- (void)cancelPressed:(UIButton *)sender{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (void)confirmPressed:(UIButton *)sender{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}


@end
