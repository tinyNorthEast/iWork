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

#import "WGProgressHUD.h"

#import "WGGetMessgesRequest.h"
#import "WGBBSListModel.h"
#import "WGCommentModel.h"
#import "WGBBSTableCell.h"
#import "WGGlobal.h"
#import "WGSignInModel.h"
#import "WGWriteBBSViewController.h"

@interface WGBBSViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation WGBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"评论";
    self.navigationController.navigationBarHidden = YES;
    
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
    [WGProgressHUD defaultLoadingOnView:self.view];
    WGGetMessgesRequest *request = [[WGGetMessgesRequest alloc] initWithToUserId:self.toUserId];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == TokenFailed) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
        else if (baseModel.infoCode.integerValue == 0) {
            [WGProgressHUD dismissOnView:self.view];
            
            WGBBSListModel *model = (WGBBSListModel *)baseModel;
            
            if (model.data.count) {
                [[WGGlobal sharedInstance] addDefaultImageViewTo:self.view isHidden:YES];
                [self.messages addObjectsFromArray:model.data];
                [self.tableView reloadData];
            }else{
                [[WGGlobal sharedInstance] addDefaultImageViewTo:self.view isHidden:NO];
            }
        }else{
            [[WGGlobal sharedInstance] addDefaultImageViewTo:self.view isHidden:NO];
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        [WGProgressHUD disappearFailureMessage:@"加载失败" onView:self.view];
        
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([WGGlobal sharedInstance].signInfo.role_code.integerValue == UserRole_Hunter) {
        WGCommentModel *aComment = self.messages[indexPath.row];
        if ([[WGGlobal sharedInstance] signInfo].userId.integerValue != aComment.c_from_id.integerValue) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"WriteBBS" bundle:nil];
            WGWriteBBSViewController *vc = [sb instantiateInitialViewController];
            
            vc.toUserId = aComment.c_from_id;
            vc.objId = aComment.c_main_id;
            vc.naviTitle = @"回复留言";
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
    }
}

@end
