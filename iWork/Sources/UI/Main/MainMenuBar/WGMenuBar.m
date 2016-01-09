//
//  WGMenuBar.m
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMenuBar.h"

#import "UIViewAdditions.h"
#import "UIFont+WGThemeFonts.h"
#include "UIColor+WGThemeColors.h"

#import "WGMainScrollView.h"
#import "WGIndustryModel.h"

//按钮空隙
#define BUTTONGAP 5
#define BUTTONMAX 5

@interface WGMenuBar()

@property (nonatomic, strong) NSMutableArray   *mButtonArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollBar;
@end

@implementation WGMenuBar

- (void)awakeFromNib{
    [super awakeFromNib];
}
- (NSMutableArray *)mButtonArray{
    if (!_mButtonArray) {
        _mButtonArray = [NSMutableArray array];
    }
    return _mButtonArray;
}
- (void)initMenuItems:(NSArray *)items{
    float xPos = 5.0;

    int tag = 0;
    float menuWidth = 0.0;
    for (WGIndustryModel *industry in items) {
        
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [barButton setTitle:industry.name forState:UIControlStateNormal];
        [barButton setTitleColor:[UIColor wg_themeWhiteColor] forState:UIControlStateNormal];
        [barButton setTitleColor:[UIColor wg_themeCyanColor] forState:UIControlStateSelected];
        barButton.titleLabel.font = [UIFont kFontSize13];
        [barButton setTag:tag];
        [barButton addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [barButton setSelected:NO];
        
        if (tag == 0) {
            [barButton setSelected:YES];
        }
        
        int baseWidth = 0;
        if (items.count>=BUTTONMAX) {
            baseWidth = self.scrollBar.width/BUTTONMAX;
        }else{
            baseWidth = self.scrollBar.width/items.count;
        }

        CGSize size = [barButton.titleLabel.text boundingRectWithSize:CGSizeMake(0, 40) options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes: @{ NSFontAttributeName:[UIFont kFontSize15] } context: nil].size;
        
        int vButtonWidth = (baseWidth>size.width?baseWidth:size.width);
        
        [barButton setFrame:CGRectMake(xPos, 2, vButtonWidth+BUTTONGAP, 40)];
        
        xPos = barButton.right+BUTTONGAP;
        
        [self.scrollBar addSubview:barButton];
        [self.mButtonArray addObject:barButton];
        
        menuWidth = barButton.left+barButton.width;
        tag++;
    }
    
    [self.scrollBar setContentSize:CGSizeMake(menuWidth, self.frame.size.height)];
}

- (void)selectMenu:(UIButton *)sender{
    [self changeButtonStateAtIndex:sender.tag];
    if ([_delegate respondsToSelector:@selector(clickMenuButtonAtIndex:)]) {
        [_delegate clickMenuButtonAtIndex:sender.tag];
    }
}

- (void)clickButtonAtIndex:(NSInteger)aIndex{
    UIButton *barButton = [self.mButtonArray objectAtIndex:aIndex];
    [self selectMenu:barButton];
}

#pragma mark 改变第几个button为选中状态，不发送delegate
-(void)changeButtonStateAtIndex:(NSInteger)aIndex{
    [self changeButtonsToNormalState];
    UIButton *barButton = [self.mButtonArray objectAtIndex:aIndex];
    [barButton setSelected:YES];
    barButton.titleLabel.font = [UIFont kFontSize15];
    [self moveScrolViewWithIndex:aIndex];
}

#pragma mark - 其他辅助功能
#pragma mark 取消所有button点击状态
-(void)changeButtonsToNormalState{
    for (UIButton *vButton in self.mButtonArray) {
        vButton.titleLabel.font = [UIFont kFontSize13];
        [vButton setSelected:NO];
    }
}
#pragma mark 移动button到可视的区域
-(void)moveScrolViewWithIndex:(NSInteger)aIndex{
    if (self.mButtonArray.count < aIndex) {
        return;
    }
    //宽度小于self.width肯定不需要移动
    if (self.scrollBar.contentSize.width <= self.width) {
        return;
    }

    UIButton *barButton = [self.mButtonArray objectAtIndex:aIndex];
    float vButtonOrigin = barButton.right;
    if (vButtonOrigin >= self.scrollBar.width) {
        if ((vButtonOrigin + self.scrollBar.width/2) >= self.scrollBar.contentSize.width) {
            [self.scrollBar setContentOffset:CGPointMake(self.scrollBar.contentSize.width - self.scrollBar.width, self.scrollBar.contentOffset.y) animated:YES];
            return;
        }
        
        float vMoveToContentOffset = vButtonOrigin - self.scrollBar.width/2;
        if (vMoveToContentOffset > 0) {
            [self.scrollBar setContentOffset:CGPointMake(vMoveToContentOffset, self.scrollBar.contentOffset.y) animated:YES];
        }
    }else{
        [self.scrollBar setContentOffset:CGPointMake(0, self.scrollBar.contentOffset.y) animated:YES];
        return;
    }
}

@end
