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

#import "WGNotificationCell.h"
#import "WGNotificationRequest.h"
#import "WGNotificationListModel.h"
#import "WGNotificationModel.h"

@interface WGNotificationController ()

@property (nonatomic, strong) NSMutableArray *notifications;

@end

@implementation WGNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
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

#pragma mark - Request
- (void)fetchNotifications{
    WGNotificationRequest *request = [[WGNotificationRequest alloc] init];
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
