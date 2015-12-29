//
//  WGBBSTableCell.m
//  iWork
//
//  Created by Adele on 12/21/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBBSTableCell.h"

#import <XXNibBridge.h>

#import "UIImageView+WGHTTP.h"
#import "WGDateFormatter.h"

#import "WGCommentModel.h"

@interface WGBBSTableCell()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation WGBBSTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(WGCommentModel *)comment{
    [self.headerImage wg_loadImageFromURL:comment.pic placeholder:[UIImage imageNamed:@"bbs_defaultHeader"]];
//    self.nameLabel.text = comment.
    self.contentLabel.text = comment.content;
    self.timeLabel.text = [[WGDateFormatter sharedInstance] formatTime:comment.create_time];
}

@end
