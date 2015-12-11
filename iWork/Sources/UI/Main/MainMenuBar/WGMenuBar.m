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
    UIImageView *shadowImageView;
    NSInteger userSelectedChannelID;
    NSInteger scrollViewSelectedChannelID; 
}

@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollBar;
@end

@implementation WGMenuBar

- (void)awakeFromNib{
    [super awakeFromNib];
    
    userSelectedChannelID = 100;
    scrollViewSelectedChannelID = 100;
}

- (void)initMenuItems:(NSArray *)items{
    float xPos = 5.0;
    for (int i = 0; i < items.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [items objectAtIndex:i];
        
        [button setTag:i+100];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [button setTitleColor:[UIColor wg_themeWhiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor wg_themeCyanColor]
                     forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        
        int buttonWidth = self.scrollBar.width/items.count;
        
//        int buttonWidth = 0;
//        if (items.count <= BUTTONGAP) {
//
//        }else{
//            
//        }
//        int buttonWidth = [title sizeWithFont:button.titleLabel.font
//                            constrainedToSize:CGSizeMake(150, 30)
//                                lineBreakMode:NSLineBreakByClipping].width;
        
        button.frame = CGRectMake(xPos, 9, buttonWidth+BUTTONGAP, 30);
        
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [self.scrollBar addSubview:button];
    }
    
    self.scrollBar.contentSize = CGSizeMake(xPos, 44);
    
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 0, [[_buttonWithArray objectAtIndex:0] floatValue], 44)];
    [shadowImageView setImage:[UIImage imageNamed:@"red_line_and_shadow.png"]];
    [self addSubview:shadowImageView];
    
}

- (void)selectMenu:(UIButton *)sender{
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:BUTTONID] floatValue], 44)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新闻页出现
                [[WGMainScrollView sharedInstance] setContentOffset:CGPointMake(BUTTONID*self.width, 0) animated:YES];
                //赋值滑动列表选择频道ID
                scrollViewSelectedChannelID = sender.tag;
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID] floatValue];
    
    if (sender.frame.origin.x - self.scrollBar.contentOffset.x > self.width-(BUTTONGAP+width)) {
        [self.scrollBar setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (sender.frame.origin.x - self.scrollBar.contentOffset.x < 5) {
        [self.scrollBar setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}

@end
