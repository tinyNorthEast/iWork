//
//  WGMenuBar.m
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMenuBar.h"

#import <XXNibBridge.h>

#import "UIViewAdditions.h"
#import "UIFont+WGThemeFonts.h"
#include "UIColor+WGThemeColors.h"
#import "WGMainScrollView.h"


//按钮空隙
#define BUTTONGAP 5
#define BUTTONID (sender.tag-100)
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)

@interface WGMenuBar()<XXNibBridge>{
    float                 mTotalWidth;
}

@property (nonatomic, strong) NSMutableArray   *mButtonArray;
@property (nonatomic, strong) NSMutableArray   *mItemInfoArray;

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
- (NSMutableArray *)mItemInfoArray{
    if (!_mItemInfoArray) {
        _mItemInfoArray = [NSMutableArray array];
    }
    return _mItemInfoArray;
}
- (void)initMenuItems:(NSArray *)items{
    int i = 0;
    float menuWidth = 0.0;
    for (NSString *title in items) {
        
        UIButton *vButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i == 0) {
            [vButton setSelected:YES];
        }
//        [vButton setBackgroundImage:[UIImage imageNamed:vNormalImageStr] forState:UIControlStateNormal];
//        [vButton setBackgroundImage:[UIImage imageNamed:vHeligtImageStr] forState:UIControlStateSelected];
        [vButton setTitle:title forState:UIControlStateNormal];
        [vButton setTitleColor:[UIColor wg_themeWhiteColor] forState:UIControlStateNormal];
        [vButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [vButton setTag:i];
        [vButton addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        int vButtonWidth = self.scrollBar.width/5;
        [vButton setFrame:CGRectMake(menuWidth, 0, vButtonWidth, self.height)];
        [self.scrollBar addSubview:vButton];
        [self.mButtonArray addObject:vButton];
        
        menuWidth += vButtonWidth;
        i++;
    }
    
    [self.scrollBar setContentSize:CGSizeMake(menuWidth, self.frame.size.height)];
    
    // 保存menu总长度，如果小于self.view.width则不需要移动，方便点击button时移动位置的判断
//    mTotalWidth = menuWidth;
}

- (void)selectMenu:(UIButton *)sender{
    [self changeButtonStateAtIndex:sender.tag];
    if ([_delegate respondsToSelector:@selector(clickMenuButtonAtIndex:)]) {
        [_delegate clickMenuButtonAtIndex:sender.tag];
    }
}
#pragma mark 改变第几个button为选中状态，不发送delegate
-(void)changeButtonStateAtIndex:(NSInteger)aIndex{
    UIButton *vButton = [self.mButtonArray objectAtIndex:aIndex];
    [self changeButtonsToNormalState];
    vButton.selected = YES;
    [self moveScrolViewWithIndex:aIndex];
}

#pragma mark - 其他辅助功能
#pragma mark 取消所有button点击状态
-(void)changeButtonsToNormalState{
    for (UIButton *vButton in self.mButtonArray) {
        vButton.selected = NO;
    }
}
#pragma mark 移动button到可视的区域
-(void)moveScrolViewWithIndex:(NSInteger)aIndex{
    if (self.mItemInfoArray.count < aIndex) {
        return;
    }
    //宽度小于self.width肯定不需要移动
    if (mTotalWidth <= self.width) {
        return;
    }

    float vButtonOrigin = self.scrollBar.width/5*aIndex;
    if (vButtonOrigin >= 300) {
        if ((vButtonOrigin + 180) >= self.scrollBar.contentSize.width) {
            [self.scrollBar setContentOffset:CGPointMake(self.scrollBar.contentSize.width - self.scrollBar.width, self.scrollBar.contentOffset.y) animated:YES];
            return;
        }
        
        float vMoveToContentOffset = vButtonOrigin - 180;
        if (vMoveToContentOffset > 0) {
            [self.scrollBar setContentOffset:CGPointMake(vMoveToContentOffset, self.scrollBar.contentOffset.y) animated:YES];
        }
    }else{
        [self.scrollBar setContentOffset:CGPointMake(0, self.scrollBar.contentOffset.y) animated:YES];
        return;
    }
}

@end
