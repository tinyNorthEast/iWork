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

#import "WGNotificationModel.h"
#import "WGNotifiCategoryListModel.h"

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

#pragma mark - IBAcion
- (IBAction)agreeAction:(id)sender {
    if (self.controlPermission) {
        self.controlPermission(@(1));
    }
}
- (IBAction)disagreeAction:(id)sender {
    if (self.controlPermission) {
        self.controlPermission(@(0));
    }
}


@end
