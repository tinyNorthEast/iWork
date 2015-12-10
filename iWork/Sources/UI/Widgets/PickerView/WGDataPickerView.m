//
//  WGDataPickerView.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDataPickerView.h"

#import <extobjc.h>

#import "UIViewAdditions.h"
#import "WGToolBarView.h"
#import "UIColor+WGThemeColors.h"
#import "UIFont+WGThemeFonts.h"

@interface WGDataPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy  ) PickerViewSelectBlock pickerViewSelectBlock;

@property (nonatomic, copy  ) PickerViewCancelBlock pickerViewCancelBlock;

@property (nonatomic, strong) UIView                *maskView;

@property (nonatomic, strong) WGToolBarView   *toolBarView;

@property (nonatomic, strong) UIPickerView          *datePicker;

@end

@implementation WGDataPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setReloadForNow];
        [self initStyle];
    }
    return self;
}

- (void)maskSubview
{
    if (self.superview && !self.maskView) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.superview.height)];
    } else {
        [self.maskView removeFromSuperview];
    }
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.0f;
    [UIView animateWithDuration:.3 animations:^{
        self.maskView.alpha = .7f;
        [self.superview insertSubview:self.maskView belowSubview:self];
    }];
}

- (void)clearMaskSubView
{
    [UIView animateWithDuration:.3 animations:^{
        self.maskView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

-(void)dealloc{
    _datePicker.delegate = nil;
    _datePicker.dataSource = nil;
}

-(void)initStyle
{
    [self addSubview:self.toolBarView];
    
    _datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.toolBarView.bottom, self.screenFrame.size.width, 250)];
    
    _datePicker.dataSource = self;
    _datePicker.delegate = self;
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.showsSelectionIndicator = YES;
    [_datePicker reloadAllComponents];
    [self addSubview:_datePicker];
}

- (WGToolBarView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[WGToolBarView alloc] initWithFrame:CGRectMake(0, 0, self.screenFrame.size.width, 50)];
        
        @weakify(self);
        _toolBarView.cancelBlock = ^{
            @strongify(self);
            if (self.pickerViewCancelBlock != nil) {
                self.pickerViewCancelBlock();
            }
            [self clearMaskSubView];
            if (self.autoHidden) {
                [self hiddenAnim];
            }
        };
        _toolBarView.confirmBlock = ^{
            @strongify(self);
            if (self.pickerViewSelectBlock != nil) {
                
                NSInteger selectRow = [self.datePicker selectedRowInComponent:0];
                self.pickerViewSelectBlock(selectRow);
            }
            [self clearMaskSubView];
            if (self.autoHidden) {
                [self hiddenAnim];
            }
        };
    }
    return _toolBarView;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
- (void)setReloadForNow{
    if (_datePicker != nil) {
        [_datePicker reloadAllComponents];
    }
}

#pragma -mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pv{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

#pragma -mark UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    [[pickerView.subviews objectAtIndex:1] setBackgroundColor:[UIColor wg_themeLightGrayColor]];
    [[pickerView.subviews objectAtIndex:2] setBackgroundColor:[UIColor wg_themeLightGrayColor]];
    
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    retval.textAlignment = NSTextAlignmentCenter;
    retval.font = [UIFont kFontSize14];
    retval.textColor = [UIColor wg_themeGrayColor];
    retval.text = self.dataArray[row];
    retval.backgroundColor = [UIColor clearColor];
    
    return retval;
}

#pragma mark - Setter method
- (void)setBarTitle:(NSString *)barTitle{
    self.toolBarView.title = barTitle;
}

#pragma mark -

- (void)showSelectDate:(PickerViewSelectBlock)aPickerViewSelectBlock
                cancel:(PickerViewCancelBlock)aPickerViewCancelBlock{
    
    if (_datePicker != nil) {
        [_datePicker reloadAllComponents];
    }
    
    self.pickerViewSelectBlock = aPickerViewSelectBlock;
    self.pickerViewCancelBlock = aPickerViewCancelBlock;
}

- (void)setSelectIndex:(NSInteger)index{
    
    if (index >= [self.dataArray count]) {
        return;
    }
    if (index < 0) {
        index = 0;
    }
    
    [_datePicker selectRow:index inComponent:0 animated:NO];
}

- (void)showInView:(UIView *)view{
    
    if (!view) {
        return;
    }
    [view addSubview:self];
    [self maskSubview];
    
    __block CGRect rect = self.frame;
    rect.origin.y = CGRectGetMaxY(view.frame);
    self.frame = rect;
    float finishy = CGRectGetMaxY(_datePicker.frame);
    [UIView animateWithDuration:0.3 animations:^{
        rect.origin.y = rect.origin.y - finishy;
        self.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenAnim{
    __block CGRect rect = self.frame;
    rect.origin.y = CGRectGetMaxY(self.superview.frame);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
