//
//  UIScrollView+Pager.h
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WGPager.h"

@interface WGPager (ScrollViewExtension)

- (void)addPullDownRefreshHandler:(void(^)(WGPager *pager))handler;
- (void)addLoadMoreHandler:(void(^)(WGPager *pager))handler;

- (void)finishRefreshWithError:(NSError *)error;
- (void)finishLoadMoreWithError:(NSError *)error;

- (void)triggerRefresh;

@end

@interface UIScrollView (Pager)

@property (nonatomic, strong, readonly) WGPager *wg_pager;

@end
