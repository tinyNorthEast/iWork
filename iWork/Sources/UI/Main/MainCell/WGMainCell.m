
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

#import "UIViewAdditions.h"
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
    if (hunter.ranking.integerValue == 1) {
        self.rateImage.image = [UIImage imageNamed:@"main_rank1"];
        self.rateLabel.text = @"人气顾问第一名";
        
    }else if (hunter.ranking.integerValue == 2){
        self.rateImage.image = [UIImage imageNamed:@"main_rank2"];
        self.rateLabel.text = @"人气顾问第二名";
        
    }else if (hunter.ranking.integerValue == 3){
        self.rateImage.image = [UIImage imageNamed:@"main_rank3"];
        self.rateLabel.text = @"人气顾问第三名";
    }
    
    
    [self.headerImage wg_loadImageFromURL:hunter.pic placeholder:[UIImage imageNamed:@"main_defaultHeader"]];
    [self.nameLabel setText:hunter.realName];
    
    NSArray *industrys = hunter.industryList;
    if (industrys.count) {
        NSString *positionStr = nil;
        for (WGIndustryModel *aModel in industrys) {
            if (positionStr.length == 0) {
                positionStr = aModel.name;
            }else{
                positionStr = [positionStr stringByAppendingString:[NSString stringWithFormat:@",%@" ,aModel.name]];
            }
        }
        self.positionLabel.text = positionStr;
    }
    
    M13BadgeView *badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(self.commentButton.right-12, 12, 24.0, 24.0)];
    [self.commentButton addSubview:badgeView];
    badgeView.text = @"9";//self.hunter.commentCount.stringValue;
    badgeView.badgeBackgroundColor = [UIColor wg_themeCyanColor];
    badgeView.hidesWhenZero = YES;
}
- (IBAction)commentAction:(id)sender {
    if (self.selectBBS) {
        self.selectBBS();
    }
}

@end
