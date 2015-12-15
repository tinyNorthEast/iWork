//
//  WGMainView.m
//  iWork
//
//  Created by Adele on 12/11/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainView.h"

#import <XXNibBridge.h>

#import "WGMenuBar.h"
#import "WGMainScrollView.h"

@interface WGMainView()<XXNibBridge,WGMenuBarDelegate,WGMainScrollViewDelegate>
@property (weak, nonatomic) IBOutlet WGMenuBar *menuBar;
@property (weak, nonatomic) IBOutlet WGMainScrollView *mainScrollView;

@end

@implementation WGMainView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self initView];
}

- (void)initView{
     NSArray *barItems = @[@"法务",@"财务",@"HR",@"消费品",@"互联网&通讯",@"汽车&机械",@"金融服务",@"供应链",@"化工",@"医疗&生命科学",@"地产"];
    [self.menuBar initMenuItems:barItems];
    self.menuBar.delegate = self;
    
    [self.mainScrollView initWithViews:barItems];
    self.mainScrollView.mainScrolldelegate = self;
}

#pragma mark - WGMenuBarDelegate
- (void)clickMenuButtonAtIndex:(NSInteger)index{
    [self.mainScrollView moveScrollowViewAthIndex:index];
}
#pragma mark - WGMainScrollViewDelegate
- (void)didScrollPageViewChangedPage:(NSInteger)aPage{
    [self.menuBar changeButtonStateAtIndex:aPage];
    //刷新当页数据
//    [mScrollPageView freshContentTableAtIndex:aPage];

}

@end
