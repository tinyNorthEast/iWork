//
//  ViewController.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainViewController.h"

#import <extobjc.h>
#import <XXNibBridge.h>

#import "WGMainCell.h"
#import "UIScrollView+WGPager.h"


@interface WGMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray  *hunters;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[WGMainCell xx_nib] forCellReuseIdentifier:[WGMainCell xx_nibID]];
    
    [self.tableView.wg_pager addPullDownRefreshHandler:^(WGPager *pager) {
        
    }];
    [self.tableView.wg_pager addLoadMoreHandler:^(WGPager *pager) {
        
    }];
    [self.tableView.wg_pager triggerRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)signAciton:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
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
//    NSDictionary *dic = self.hunters[indexPath.row];
//    cell.hunters =
}

#pragma mark - UITableViewDelegate


@end
