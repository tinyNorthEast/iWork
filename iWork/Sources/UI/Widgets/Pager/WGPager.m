//
//  WGPager.m
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGPager.h"

@implementation WGPager

- (instancetype)init{
    self = [super init];
    if (self) {
        _nextPageIndex = 20;
    }
    return self;
}

- (NSUInteger)nextPageIndex{
    return _currentPageIndex+1;
}

@end
