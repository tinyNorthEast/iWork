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

@interface WGMainScrollView()<UIScrollViewDelegate>{
    BOOL mNeedUseDelegate;
    NSInteger mCurrentPage;
}

@end

@implementation WGMainScrollView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.delegate = self;
    mNeedUseDelegate = YES;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initWithViews:(NSArray *)itmes{
    for (int index = 0; index < itmes.count; index++) {
        WGMainTableView *vCustomTableView = [[WGMainTableView alloc] initWithFrame:CGRectMake(self.width * index, 0, self.width, self.frame.size.height)];
        [vCustomTableView setTag:index];
        [self addSubview:vCustomTableView];
    }
    [self setContentSize:CGSizeMake(self.width * itmes.count, self.height)];
}

- (void)moveScrollowViewAthIndex:(NSInteger)aIndex{
    mNeedUseDelegate = NO;
    CGRect vMoveRect = CGRectMake(self.width * aIndex, 0, self.width, self.width);
    [self scrollRectToVisible:vMoveRect animated:YES];
    mCurrentPage= aIndex;
    if ([_mainScrolldelegate respondsToSelector:@selector(didScrollPageViewChangedPage:)]) {
        [_mainScrolldelegate didScrollPageViewChangedPage:mCurrentPage];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    mNeedUseDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (self.contentOffset.x+self.width/2.0) / self.width;
    if (mCurrentPage == page) {
        return;
    }
    mCurrentPage= page;
    if ([_mainScrolldelegate respondsToSelector:@selector(didScrollPageViewChangedPage:)] && mNeedUseDelegate) {
        [_mainScrolldelegate didScrollPageViewChangedPage:mCurrentPage];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        //        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        //        targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
        //        [self moveToTargetPosition:targetX];
    }
}

@end
