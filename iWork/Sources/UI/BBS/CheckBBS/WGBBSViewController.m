//
//  WGBBSViewController.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBBSViewController.h"

#import <extobjc.h>
#import <XXNibBridge.h>

#import "WGGetMessgesRequest.h"
#import "WGBBSListModel.h"
#import "WGCommentModel.h"
#import "WGBBSTableCell.h"

@interface WGBBSViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation WGBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    
    [self requestMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
- (NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

#pragma mark - Request
- (void)requestMessages{
    WGGetMessgesRequest *request = [[WGGetMessgesRequest alloc] initWithToUserId:@(16)];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        WGBBSListModel *model = (WGBBSListModel *)baseModel;
        
        [self.messages addObjectsFromArray:model.data];
        
        [self.tableView reloadData];
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WGBBSTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGBBSTableCell xx_nibID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(WGBBSTableCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    WGCommentModel *aComment = self.messages[indexPath.row];
    cell.comment = aComment;
}

@end
