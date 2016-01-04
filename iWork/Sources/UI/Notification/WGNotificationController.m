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

#import "WGNotificationCell.h"
#import "WGNotificationRequest.h"
#import "WGNotificationListModel.h"
#import "WGNotificationModel.h"
#import "WGDeleteNotificationRequest.h"

@interface WGNotificationController ()

@property (nonatomic, strong) NSMutableArray *notifications;

@end

@implementation WGNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    [self fetchNotifications];
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
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        WGNotificationListModel *model = (WGNotificationListModel *)baseModel;
        [self.notifications addObjectsFromArray:model.data];
        if (self.notifications.count) {
            [self.tableView reloadData];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notifications.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGNotificationCell xx_nibID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            if (baseModel.infoCode.integerValue == 0) {
                [self.notifications removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            
        }];
        
        
        // Delete the row from the data source
        
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
