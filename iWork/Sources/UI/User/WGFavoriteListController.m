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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
