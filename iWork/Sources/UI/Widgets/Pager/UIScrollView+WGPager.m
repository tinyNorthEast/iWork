//
//  UIScrollView+WGPager.m
//  iWork
//
//  Created by Adele on 11/18/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "UIScrollView+WGPager.h"

#import <extobjc.h>
#import "MJRefresh.h"

@implementation WGPager(ScrollViewExtension)

- (instancetype)initWithScrollView:(UIScrollView *)scrollView{
    self = [super init];
    if (self) {
        self.referScrollView = scrollView;
    }
    return self;
}

- (void)addPullDownRefreshHandler:(void(^)(WGPager *pager))handler{
    @weakify(self);
    
    self.referScrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.currentPageIndex = 1;
        if (handler) {
            handler(self);
        }
        
    }];
}
- (void)addLoadMoreHandler:(void(^)(WGPager *pager))handler{
    
    @weakify(self);
    self.referScrollView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        if (handler) {
            handler(self);
        }
    }];
}

- (void)finishRefreshWithError:(NSError *)error{
    if (!error) {
        self.currentPageIndex = 1;
        self.totalCount = self.nextPageIndex;
    }
    [self.referScrollView.header endRefreshing];
    
}
- (void)finishLoadMoreWithError:(NSError *)error{
    if (!error) {
        self.currentPageIndex = self.nextPageIndex;
        self.totalCount += self.nextPageIndex;
    }
    [self.referScrollView.footer endRefreshing];
}

- (void)triggerRefresh{
    [self.referScrollView.header beginRefreshing];
}

@end

@implementation UIScrollView (WGPager)

- (WGPager *)wg_pager{
    WGPager *pager = objc_getAssociatedObject(self, _cmd);
    if (!pager) {
        pager = [[WGPager alloc] initWithScrollView:self];
        objc_setAssociatedObject(self, _cmd, pager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return pager;
}

@end
