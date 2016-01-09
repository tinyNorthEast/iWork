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
#import "WGGlobal.h"

#import "WGMainCell.h"
#import "UIScrollView+WGPager.h"
#import "WGMainViewController.h"
#import "WGBBSViewController.h"
#import "WGHunterListRequest.h"
#import "WGBaseModel.h"
#import "WGHunterListModel.h"
#import "WGHunterModel.h"
#import "WGIndustryModel.h"
#import "WGHunterDetailViewController.h"

#define DefaultCityCode 1000

@interface WGMainTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *hunters;
@property (nonatomic, strong) NSNumber *areaCode;

@end
@implementation WGMainTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = 255;
        [self registerNib:[WGMainCell xx_nib] forCellReuseIdentifier:[WGMainCell xx_nibID]];
        
        
        @weakify(self);
        [self.wg_pager addPullDownRefreshHandler:^(WGPager *pager) {
            @strongify(self);
            [self.hunters removeAllObjects];
            [self requestHuntersWithPage:pager isRefresh:YES];
        }];
        [self.wg_pager addLoadMoreHandler:^(WGPager *pager) {
            @strongify(self);
            [self requestHuntersWithPage:pager isRefresh:NO];
        }];
        
    }
    return self;
}

- (NSMutableArray *)hunters{
    if (!_hunters) {
        _hunters = [NSMutableArray array];
    }
    return _hunters;
}

- (void)freshDataAtCity:(NSNumber *)areaCode{
    self.areaCode = areaCode;
    
    [self.wg_pager triggerRefresh];
}

#pragma mark - Request
//根据table tag重找industry id
- (void)requestHuntersWithPage:(WGPager *)pager isRefresh:(BOOL)isRefresh{
    NSArray *lists = [[WGGlobal sharedInstance] industryLists];
    WGIndustryModel *industry = [lists objectAtIndex:self.tag];
    
    
    if (self.areaCode.integerValue == 0) {
        self.areaCode = @(DefaultCityCode);
    }
    
    NSNumber *requestPagerNum;
    if (isRefresh) {
        requestPagerNum = @(pager.currentPageIndex);
    }else{
        requestPagerNum = @(pager.nextPageIndex);
    }
    
    
    [WGProgressHUD defaultLoadingOnView:[UIApplication sharedApplication].keyWindow];
    WGHunterListRequest *request = [[WGHunterListRequest alloc] initWithAreaCode:self.areaCode industryId:industry.objId  pageNo:requestPagerNum];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        [WGProgressHUD dismissOnView:[UIApplication sharedApplication].keyWindow];
        
        if (baseModel.infoCode.integerValue == 0) {
            WGHunterListModel *model = (WGHunterListModel *)baseModel;
            [self.hunters addObjectsFromArray:model.data];
            if (self.hunters.count) {
                [self reloadData];
            }
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:[UIApplication sharedApplication].keyWindow];
        }
        if (isRefresh) {
            [pager finishRefreshWithError:error];
        }else{
            [pager finishLoadMoreWithError:error];
        }
        
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        if (isRefresh) {
            [pager finishRefreshWithError:error];
        }else{
            [pager finishLoadMoreWithError:error];
        }
    }];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[WGMainViewController class]]) {
            return (WGMainViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hunters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WGMainCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGMainCell xx_nibID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(WGMainCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    if (self.hunters.count) {
        WGHunterModel *aHunter = self.hunters[indexPath.row];
        cell.hunter = aHunter;
    }
    @weakify(self);
    cell.selectBBS = ^{
        @strongify(self);
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BBS" bundle:nil];
        WGBBSViewController *vc = [sb instantiateInitialViewController];;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    };
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    WGHunterDetailViewController *vc = [sb instantiateInitialViewController];
    WGHunterModel *aHunter = self.hunters[indexPath.row];
    vc.hunterId = aHunter.objId;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}
@end
