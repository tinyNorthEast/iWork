//
//  WGFavoriteCell.m
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGFavoriteCell.h"

#import "UIImageView+WGHTTP.h"
#import "WGDateFormatter.h"

#import "WGFavoriteModel.h"

@interface WGFavoriteCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WGFavoriteCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFavorite:(WGFavoriteModel *)favorite{
    [self.headerView wg_loadImageFromURL:nil placeholder:[UIImage imageNamed:@"user_defaultHeader"]];
    self.nameLabel.text = favorite.zh_name;
    self.timeLabel.text = [[WGDateFormatter sharedInstance] formatTime:favorite.create_time];
}

@end
