//
//  WGPager.h
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGPager : NSObject

@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign) NSUInteger totalCount;

@end

@interface WGPager (/*RequestParameters*/)

@property (nonatomic, assign) NSUInteger nextPageIndex;

@end

@interface WGPager (/*ScrollViewExtension*/)

@property (nonatomic, weak) UIScrollView *referScrollView;

@end
