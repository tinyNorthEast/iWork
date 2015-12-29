//
//  WGFavoriteListController.m
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGFavoriteListController.h"

#import <XXNibBridge.h>

#import "WGFavoriteCell.h"
#import "WGFavoriteListModel.h"
#import "WGFavoriteModel.h"

@interface WGFavoriteListController ()

@property (nonatomic, strong) NSMutableArray *favorites;

@end

@implementation WGFavoriteListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 64;
    [self requestFavoriteList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init
- (NSMutableArray *)favorites{
    if (!_favorites) {
        _favorites = [NSMutableArray array];
    }
    return _favorites;
}
#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)requestFavoriteList{
    WGFavoriteListRequest *request = [[WGFavoriteListRequest alloc] initWithFavoritType:self.searchType];
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        WGFavoriteListModel *model = (WGFavoriteListModel *)baseModel;
        [self.favorites addObjectsFromArray:model.data];
        [self.tableView reloadData];
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGFavoriteCell xx_nibID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(WGFavoriteCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    WGFavoriteModel *aFavorite = self.favorites[indexPath.row];
    cell.favorite = aFavorite;
}

@end
