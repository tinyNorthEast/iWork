//
//  WGMenuBar.m
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMenuBar.h"

#import <XXNibBridge.h>

#import "UIFont+WGThemeFonts.h"
#include "UIColor+WGThemeColors.h"

//按钮空隙
#define BUTTONGAP 5

@interface WGMenuBar()<XXNibBridge>{
    UIImageView *shadowImageView;
}

@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollBar;
@end

@implementation WGMenuBar

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
        [button setTitleColor:[UIColor wg_themeCyanColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor wg_themeWhiteColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = [title sizeWithFont:button.titleLabel.font
                            constrainedToSize:CGSizeMake(150, 30)
                                lineBreakMode:NSLineBreakByClipping].width;
        
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

@end
