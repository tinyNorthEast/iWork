//
//  WGBBSCell.m
//  iWork
//
//  Created by Adele on 12/31/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBBSCell.h"

#import <XXNibBridge.h>

#import "UIImageView+WGHTTP.h"
#import "WGDateFormatter.h"

#import "WGCommentModel.h"

@interface WGBBSCell()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WGBBSCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(WGCommentModel *)comment{
    [self.headerView wg_loadImageFromURL:comment.pic placeholder:[UIImage imageNamed:@"user_defaultHeader"]];
    self.nameLabel.text = comment.fromName;
    self.contentLabel.text = comment.content;
    self.timeLabel.text = [[WGDateFormatter sharedInstance] formatTime:comment.create_time];
}

@end
