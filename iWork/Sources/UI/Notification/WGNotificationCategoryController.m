//
//  WGNotificationCategoryController.m
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGNotificationCategoryController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"

#import "WGNotifyCategoryRequest.h"
#import "WGNotifiCategoryListModel.h"
#import "WGNotifiCategoryModel.h"
#import "WGNotificationController.h"

@interface WGNotificationCategoryController ()
@property (weak, nonatomic) IBOutlet UILabel *bbsNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *permissionNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *focusNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *systemNumLabel;

@end

@implementation WGNotificationCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getNoficationUnreadNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Request
- (void)getNoficationUnreadNum{
    WGNotifyCategoryRequest *request = [[WGNotifyCategoryRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        WGNotifiCategoryListModel *model = (WGNotifiCategoryListModel *)baseModel;
        if (model.infoCode.integerValue == 0) {
            [self setUnreadLabel:model.data];
        }else{
            [WGProgressHUD disappearFailureMessage:model.message onView:self.view];
        }
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
//        @strongify(self);
//        [WGProgressHUD disappearFailureMessage:@"加载失败" onView:self.viewController.view];
        
    }];
}
- (void)setUnreadLabel:(NSArray *)lists{
    for (WGNotifiCategoryModel *aModel in lists) {
        if (aModel.n_type.integerValue == WGNOTIFICATIONCATEGORY_BBS) {
            self.bbsNumLabel.text = [NSString stringWithFormat:@"您有%ld条未读消息",(long)[aModel.typeCount integerValue]];
            
        }else if (aModel.n_type.integerValue == WGNOTIFICATIONCATEGORY_PERMISION){
            self.permissionNumLabel.text = [NSString stringWithFormat:@"您有%ld条未读消息",(long)[aModel.typeCount integerValue]];
            
        }else if (aModel.n_type.integerValue == WGNOTIFICATIONCATEGORY_FOCUS){
            self.focusNumLabel.text = [NSString stringWithFormat:@"您有%ld条未读消息",(long)[aModel.typeCount integerValue]];
            
        }else if (aModel.n_type.integerValue == WGNOTIFICATIONCATEGORY_SYSTEM){
            self.systemNumLabel.text = [NSString stringWithFormat:@"您有%ld条未读消息",(long)[aModel.typeCount integerValue]];
        }
    }
}
#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WGNotificationController *vc = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"nofication_focus"]) {
        vc.notif_type = @(WGNOTIFICATIONCATEGORY_FOCUS);
    }else if ([segue.identifier isEqualToString:@"notification_permission"]) {
        vc.notif_type = @(WGNOTIFICATIONCATEGORY_PERMISION);
    }else if ([segue.identifier isEqualToString:@"notification_bbs"]) {
        vc.notif_type = @(WGNOTIFICATIONCATEGORY_BBS);
    }else if ([segue.identifier isEqualToString:@"notification_system"]) {
        vc.notif_type = @(WGNOTIFICATIONCATEGORY_SYSTEM);
    }
}


@end
