//
//  WGNotificationController.m
//  iWork
//
//  Created by Adele on 12/26/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGNotificationController.h"

#import <extobjc.h>
#import <XXNibBridge.h>

#import "WGProgressHUD.h"
#import "WGGlobal.h"

#import "WGNotificationCell.h"
#import "WGNotificationRequest.h"
#import "WGNotificationListModel.h"
#import "WGNotificationModel.h"
#import "WGDeleteNotificationRequest.h"
#import "WGNotifiCategoryListModel.h"
#import "WGBBSViewController.h"

@interface WGNotificationController ()

@property (nonatomic, strong) NSMutableArray *notifications;

@end

@implementation WGNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication]  setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self fetchNotifications];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init
- (NSMutableArray *)notifications{
    if (!_notifications) {
        _notifications = [NSMutableArray array];
    }
    return _notifications;
}
#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request
- (void)fetchNotifications{
    WGNotificationRequest *request = [[WGNotificationRequest alloc] initWithType:self.notif_type];
    [WGProgressHUD defaultLoadingOnView:self.view];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue ==0) {
            [WGProgressHUD dismissOnView:self.view];
            WGNotificationListModel *model = (WGNotificationListModel *)baseModel;
            [self.notifications addObjectsFromArray:model.data];
            if (self.notifications.count) {
                [self.tableView reloadData];
                [[WGGlobal sharedInstance] addDefaultImageViewTo:self.view isHidden:YES];
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
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notifications.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGNotificationCell xx_nibID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.notify_type = self.notif_type;
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(WGNotificationCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    WGNotificationModel *aNotification = self.notifications[indexPath.row];
    cell.notification = aNotification;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        WGNotificationModel *aNotification = self.notifications[indexPath.row];
        
        WGDeleteNotificationRequest *request = [[WGDeleteNotificationRequest alloc] initWithObjId:aNotification.objId];
        @weakify(self);
        [WGProgressHUD loadMessage:@"正在删除消息" onView:self.view];
        [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            
            [WGProgressHUD dismissOnView:self.view];
            if (baseModel.infoCode.integerValue == TokenFailed) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
                UIViewController *vc = [sb instantiateInitialViewController];
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
            }
            
            else if (baseModel.infoCode.integerValue == 0) {
                // Delete the row from the data source
                [self.notifications removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            
        }];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.notif_type integerValue] ==  WGNOTIFICATIONCATEGORY_BBS) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BBS" bundle:nil];
        WGBBSViewController *vc = [sb instantiateInitialViewController];
        WGNotificationModel *notificationModel = self.notifications[indexPath.row];
        vc.toUserId = notificationModel.user_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
