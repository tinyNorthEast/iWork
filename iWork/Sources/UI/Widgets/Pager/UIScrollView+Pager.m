//
//  UIScrollView+Pager.m
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "UIScrollView+Pager.h"

#import <extobjc.h>

@implementation WGPager(ScrollViewExtension)

- (instancetype)initWithScrollView:(UIScrollView *)scrollView{
    self = [super init];
    if (self) {
        self.referScrollView = scrollView;
    }
    return self;
}

- (void)addPullDownRefreshHandler:(void(^)(WGPager *pager))handler{
    
}
- (void)addLoadMoreHandler:(void(^)(WGPager *pager))handler{
    
}

- (void)finishRefreshWithError:(NSError *)error{
    
}
- (void)finishLoadMoreWithError:(NSError *)error{
    
}

- (void)triggerRefresh{
    
}


@end

@implementation UIScrollView (Pager)

- (WGPager *)wg_pager{
    WGPager *pager = objc_getAssociatedObject(self, _cmd);
    if (!pager) {
        pager = [[WGPager alloc] initWithScrollView:self];
        objc_setAssociatedObject(self, _cmd, pager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return pager;
}

@end
