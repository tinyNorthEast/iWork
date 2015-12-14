//
//  WGMainScrollView.h
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGMainScrollViewDelegate <NSObject>

-(void)didScrollPageViewChangedPage:(NSInteger)aPage;

@end

@interface WGMainScrollView : UIScrollView

@property (nonatomic,assign) id<WGMainScrollViewDelegate> mainScrolldelegate;

- (void)initWithViews:(NSArray *)items;


-(void)moveScrollowViewAthIndex:(NSInteger)aIndex;

@end
