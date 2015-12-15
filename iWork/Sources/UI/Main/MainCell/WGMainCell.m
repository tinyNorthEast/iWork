
//
//  WGMainTableViewCell.m
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainCell.h"

#import <XXNibBridge.h>
#import "M13BadgeView.h"

#import "UIImageView+WGHTTP.h"

#import "WGHunterModel.h"

@interface WGMainCell()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *rateImage;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *pariseButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation WGMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setHunter:(WGHunterModel *)hunter{
    [self.headerImage wg_loadImageFromURL:hunter.pic placeholder:nil];
    [self.nameLabel setText:hunter.realName];
    

    M13BadgeView *badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(0, 0, 24.0, 24.0)];
    badgeView.text = @"9";//self.hunter.commentCount.stringValue;
    badgeView.horizontalAlignment = M13BadgeViewHorizontalAlignmentRight;
    badgeView.verticalAlignment = M13BadgeViewVerticalAlignmentTop;
    badgeView.hidesWhenZero = YES;
    [self.commentButton addSubview:badgeView];
}
- (void)setHunters:(WGHunterModel *)hunters byIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }
}

- (IBAction)commentAction:(id)sender {
    if (self.selectBBS) {
        self.selectBBS();
    }
}

@end
