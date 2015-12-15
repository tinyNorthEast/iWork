//
//  WGMainTableView.m
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainTableView.h"

#import <XXNibBridge.h>
#import <extobjc.h>

#import "WGMainCell.h"
#import "UIScrollView+WGPager.h"
#import "WGMainViewController.h"
#import "WGBBSViewController.h"

@interface WGMainTableView()<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic, strong) NSMutableArray *hunters;

@end
@implementation WGMainTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        self.rowHeight = 166;
        [self registerNib:[WGMainCell xx_nib] forCellReuseIdentifier:[WGMainCell xx_nibID]];
    
        [self.wg_pager addPullDownRefreshHandler:^(WGPager *pager) {
    
        }];
        [self.wg_pager addLoadMoreHandler:^(WGPager *pager) {
    
        }];
//        [self.wg_pager triggerRefresh];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;//self.hunters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WGMainCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGMainCell xx_nibID] forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(WGMainCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    //    NSDictionary *dic = self.hunters[indexPath.row];
    //    cell.hunters =
    
    
    
    
//    @weakify(self);
    cell.selectBBS = ^{
//        @strongify(self);
        UINavigationController *topController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        WGBBSViewController *vc = [WGBBSViewController new];
        [topController pushViewController:vc animated:YES];
    };
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController *topController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"City" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [topController pushViewController:vc animated:YES];
}
@end
