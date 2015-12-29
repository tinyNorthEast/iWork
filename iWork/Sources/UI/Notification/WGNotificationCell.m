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

@interface WGNotificationCell()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

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

@end
