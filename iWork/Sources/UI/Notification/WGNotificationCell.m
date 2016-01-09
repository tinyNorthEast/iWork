//
//  WGNotificationCell.m
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGNotificationCell.h"

#import <XXNibBridge.h>

#import "WGDateFormatter.h"
#import "WGProgressHUD.h"
#import "UIViewAdditions.h"

#import "WGNotificationModel.h"
#import "WGNotifiCategoryListModel.h"
#import "WGUpdateAuthRequest.h"

@interface WGNotificationCell()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *disagreeButton;

@end

@implementation WGNotificationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNotification:(WGNotificationModel *)notification{
    self.contentLabel.text = notification.content;
    self.timeLabel.text = [[WGDateFormatter sharedInstance] formatTime:notification.create_time];
}
- (void)setNotify_type:(NSNumber *)notify_type{
    if (notify_type.integerValue == WGNOTIFICATIONCATEGORY_PERMISION) {
        [self.agreeButton setHidden:NO];
        [self.disagreeButton setHidden:NO];
    }else{
        [self.agreeButton setHidden:YES];
        [self.disagreeButton setHidden:YES];
    }
}

#pragma mark - Request
- (void)updateAuthRequestStatus:(NSNumber*)status{
    WGUpdateAuthRequest *request = [[WGUpdateAuthRequest alloc] initWithAuthId:self.notification.record_id objId:self.notification.objId status:status];
    [WGProgressHUD defaultLoadingOnView:[self viewController].view];
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        [WGProgressHUD dismissOnView:self.viewController.view];
        if (baseModel.infoCode.integerValue == 0) {
            
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.viewController.view];
        }
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}
#pragma mark - IBAcion
- (IBAction)agreeAction:(id)sender {
    if (self.controlPermission) {
        self.controlPermission(@(1));
    }
    [self updateAuthRequestStatus:@(1)];
}
- (IBAction)disagreeAction:(id)sender {
    if (self.controlPermission) {
        self.controlPermission(@(0));
        
    }
    [self updateAuthRequestStatus:@(0)];
}


@end
