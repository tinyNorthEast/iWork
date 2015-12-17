
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
#import "UIColor+WGThemeColors.h"

#import "WGHunterModel.h"
#import "WGIndustryModel.h"

@interface WGMainCell()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *rateImage;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
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
    [self.headerImage wg_loadImageFromURL:hunter.pic placeholder:[UIImage imageNamed:@"main_defaultHeader"]];
    [self.nameLabel setText:hunter.realName];
    
    
    NSArray *industrys = hunter.industryList;
    if (industrys.count) {
        NSString *positionStr = nil;
        for (WGIndustryModel *aModel in industrys) {
            if (positionStr.length == 0) {
                positionStr = aModel.industryName;
            }else{
                positionStr = [positionStr stringByAppendingString:[NSString stringWithFormat:@",%@" ,aModel.industryName]];
            }
        }
        self.positionLabel.text = positionStr;
    }
    
    M13BadgeView *badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(0, 0, 24.0, 24.0)];
    badgeView.text = @"9";//self.hunter.commentCount.stringValue;
    badgeView.badgeBackgroundColor = [UIColor wg_themeCyanColor];
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
