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

#import "WGProgressHUD.h"

#import "WGMainCell.h"
#import "UIScrollView+WGPager.h"
#import "WGMainViewController.h"
#import "WGBBSViewController.h"
#import "WGHunterListRequest.h"
#import "WGBaseModel.h"
#import "WGHunterListModel.h"
#import "WGHunterModel.h"

@interface WGMainTableView()<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic, strong) NSMutableArray *hunters;

@end
@implementation WGMainTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        self.rowHeight = 166;
        [self registerNib:[WGMainCell xx_nib] forCellReuseIdentifier:[WGMainCell xx_nibID]];
    
        @weakify(self);
        [self.wg_pager addPullDownRefreshHandler:^(WGPager *pager) {
            @strongify(self);
            [self requestHuntersWithPage:pager];
        }];
        [self.wg_pager addLoadMoreHandler:^(WGPager *pager) {
    
        }];
//        [self.wg_pager triggerRefresh];
    }
    return self;
}

- (NSMutableArray *)hunters{
    if (!_hunters) {
        _hunters = [NSMutableArray array];
    }
    return _hunters;
}

#pragma mark - Request
- (void)requestHuntersWithPage:(WGPager *)pager{
    WGHunterListRequest *request = [[WGHunterListRequest alloc] initWithAreaCode:@"1000" industryId:@"-1" pageNo:@(pager.currentPageIndex)];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == 0) {
            WGHunterListModel *model = (WGHunterListModel *)baseModel;
            [self.hunters addObjectsFromArray:model.data];
            if (self.hunters.count) {
                [self reloadData];
            }
            
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self];
        }
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hunters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WGMainCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGMainCell xx_nibID] forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(WGMainCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    WGHunterModel *aHunter = self.hunters[indexPath.row];
    cell.hunter = aHunter;
    

    
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
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [topController pushViewController:vc animated:YES];
}
@end
