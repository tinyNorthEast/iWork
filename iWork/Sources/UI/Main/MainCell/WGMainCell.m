
//
//  WGMainTableViewCell.m
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainCell.h"

#import <extobjc.h>
#import <XXNibBridge.h>
#import "M13BadgeView.h"

#import "WGProgressHUD.h"
#import "UIViewAdditions.h"
#import "UIImageView+WGHTTP.h"
#import "UIColor+WGThemeColors.h"

#import "WGGlobal.h"
#import "WGSignInModel.h"
#import "WGHunterModel.h"
#import "WGHunterIndustryModel.h"
#import "WGAttentionRequest.h"

@interface WGMainCell()<XXNibBridge>
@property (nonatomic, assign) NSUInteger praiseTag;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *rateImage;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;

@end

@implementation WGMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    
}
- (void)setHunter:(WGHunterModel *)hunter{
    _hunter = hunter;
    
    if (hunter.ranking.integerValue == 1) {
        self.rateImage.image = [UIImage imageNamed:@"main_rank1"];
        self.rateLabel.text = @"人气顾问第一名";
        
    }else if (hunter.ranking.integerValue == 2){
        self.rateImage.image = [UIImage imageNamed:@"main_rank2"];
        self.rateLabel.text = @"人气顾问第二名";
        
    }else if (hunter.ranking.integerValue == 3){
        self.rateImage.image = [UIImage imageNamed:@"main_rank3"];
        self.rateLabel.text = @"人气顾问第三名";
    }else{
        self.rateImage.image = nil;
        self.rateLabel.text = @"";
    }
    
    
    [self.headerImage wg_loadImageFromURL:hunter.pic placeholder:[UIImage imageNamed:@"main_defaultHeader"]];
    [self.nameLabel setText:hunter.realName];
    
    CGSize size = [self.nameLabel.text boundingRectWithSize:CGSizeMake(0, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes: @{ NSFontAttributeName:self.nameLabel.font } context: nil].size;
    
    
    self.nameWidth.constant = size.width;
    
    
    
    self.positionLabel.text = @"";
    NSArray *industrys = hunter.industryList;
    if (industrys.count) {
        NSString *positionStr = nil;
        for (WGHunterIndustryModel *aModel in industrys) {
            if (positionStr.length == 0) {
                positionStr = aModel.industryName;
            }else{
                positionStr = [positionStr stringByAppendingString:[NSString stringWithFormat:@" | %@" ,aModel.industryName]];
            }
        }
        self.positionLabel.text = positionStr;
    }
    
    if (hunter.isAttention.integerValue == 0) {
        [self.pariseButton setImage:[UIImage imageNamed:@"main_favorite"] forState:UIControlStateNormal];
    }else{
        [self.pariseButton setImage:[UIImage imageNamed:@"detail_favorite2"] forState:UIControlStateNormal];
    }
    
    M13BadgeView *badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(self.commentButton.right-12, 12, 24.0, 24.0)];
    [self.commentButton addSubview:badgeView];
    badgeView.text = self.hunter.commentCount.stringValue;
    badgeView.badgeBackgroundColor = [UIColor wg_themeCyanColor];
    badgeView.hidesWhenZero = YES;
}
- (void)gotoLoginView{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self.viewController presentViewController:vc animated:YES completion:^{
        
    }];
}
- (IBAction)commentAction:(id)sender {
    if ([WGGlobal sharedInstance].userToken.length == 0) {
        [self gotoLoginView];
    }else{
        if (self.selectBBS) {
            self.selectBBS(self);
        }
    }
}
- (IBAction)praiseButton:(id)sender {
    if ([WGGlobal sharedInstance].userToken.length == 0) {
        [self gotoLoginView];
    }else{
        if ([[WGGlobal sharedInstance] signInfo].userId.integerValue == self.hunter.userId.integerValue){
            return;
        }
            
        BOOL isAttention = self.hunter.isAttention.integerValue;
        
        WGAttentionRequest *request = [[WGAttentionRequest alloc] initAttention:@(!isAttention) toId:self.hunter.userId];
        @weakify(self);
        [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            if (baseModel.infoCode.integerValue == 0) {
                if (self.hunter.isAttention.integerValue == 0) {
                    [self.pariseButton setImage:[UIImage imageNamed:@"detail_favorite2"] forState:UIControlStateNormal];
                }else{
                    [self.pariseButton setImage:[UIImage imageNamed:@"main_favorite"] forState:UIControlStateNormal];
                }
                CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
                k.values = @[@(0.1),@(1.0),@(1.5)];
                k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
                k.calculationMode = kCAAnimationLinear;
                [self.pariseButton.layer addAnimation:k forKey:@"SHOW"];
                
                
                if (self.selectCell) {
                    self.selectCell(self,!self.hunter.isAttention);
                }
                
                
            }else{
                [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.viewController.view];
            }
            
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            [WGProgressHUD disappearFailureMessage:@"加载失败" onView:self.viewController.view];
            
        }];
    }
}

@end
