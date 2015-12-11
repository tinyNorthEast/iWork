//
//  WGMainScrollView.m
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainScrollView.h"

#import "UIViewAdditions.h"
#import "WGMainTableView.h"

@interface WGMainScrollView()<UIScrollViewDelegate>

@end

@implementation WGMainScrollView

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(WGMainScrollView)

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)initWithViews:(NSArray *)itmes{
    for (int i = 0; i < itmes.count; i++) {
        WGMainTableView *vCustomTableView = [[WGMainTableView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width, self.frame.size.height)];
        [self addSubview:vCustomTableView];
        
        //为table添加嵌套HeadderView
//        [self addLoopScrollowView:vCustomTableView];
//        [_contentItems addObject:vCustomTableView];
    }
    [self setContentSize:CGSizeMake(self.width * itmes.count, self.height)];
}

@end
