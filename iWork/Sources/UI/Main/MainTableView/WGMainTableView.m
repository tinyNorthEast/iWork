//
//  WGMainTableView.m
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainTableView.h"

#import <XXNibBridge.h>

#import "WGMainCell.h"
#import "UIScrollView+WGPager.h"

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
        
        [self registerNib:[WGMainCell xx_nib] forCellReuseIdentifier:[WGMainCell xx_nibID]];
    
        [self.wg_pager addPullDownRefreshHandler:^(WGPager *pager) {
    
        }];
        [self.wg_pager addLoadMoreHandler:^(WGPager *pager) {
    
        }];
        [self.wg_pager triggerRefresh];
    }
    return self;
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
    //    NSDictionary *dic = self.hunters[indexPath.row];
    //    cell.hunters =
}

#pragma mark - UITableViewDelegate

@end
