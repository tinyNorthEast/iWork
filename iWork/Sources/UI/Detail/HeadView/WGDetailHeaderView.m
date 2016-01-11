//
//  WGDetailHeaderView.m
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDetailHeaderView.h"

#import <extobjc.h>
#import <XXNibBridge.h>

#import "UIViewAdditions.h"
#import "UIImageView+WGHTTP.h"

#import "WGGlobal.h"
#import "WGHunterInfoModel.h"
#import "WGHunterDetailViewController.h"
#import "WGBBSViewController.h"
#import "WGAttentionRequest.h"

@interface WGDetailHeaderView()<XXNibBridge>
@property (nonatomic, assign) NSUInteger praiseTag;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation WGDetailHeaderView

#pragma mark - Init
- (void)setInfoModel:(WGHunterInfoModel *)infoModel{
    _infoModel = infoModel;
    [self.headerImage wg_loadImageFromURL:infoModel.pic placeholder:[UIImage imageNamed:@"detail_defaultHeader"]];
    self.nameLabel.text = infoModel.realName;
    if (infoModel.isAttention.integerValue == 0) {
        [self.praiseButton setImage:[UIImage imageNamed:@"detail_favorite1"] forState:UIControlStateNormal];
    }else{
        [self.praiseButton setImage:[UIImage imageNamed:@"detail_favorite2"] forState:UIControlStateNormal];
    }
}

#pragma mark - IBAction
//- (UIViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[WGHunterDetailViewController class]]) {
//            return (WGHunterDetailViewController *)nextResponder;
//        }
//    }
//    return nil;
//}
- (BOOL)isSignIn{
    return ([[WGGlobal sharedInstance] userToken].length>0?YES:NO);
}
- (IBAction)praiseAction:(id)sender {
    if ([self isSignIn]) {
        BOOL isAttention = self.infoModel.isAttention.integerValue;
        
        WGAttentionRequest *request = [[WGAttentionRequest alloc] initAttention:@(!isAttention) toId:self.infoModel.userId];
        @weakify(self);
        [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            if (baseModel.infoCode.integerValue == 0) {
                if (self.infoModel.isAttention.integerValue == 0) {
                    [self.self.praiseButton setImage:[UIImage imageNamed:@"detail_favorite2"] forState:UIControlStateNormal];
                }else{
                    [self.self.praiseButton setImage:[UIImage imageNamed:@"detail_favorite1"] forState:UIControlStateNormal];
                }
                CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
                k.values = @[@(0.1),@(1.0),@(1.5)];
                k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
                k.calculationMode = kCAAnimationLinear;
                [self.self.praiseButton.layer addAnimation:k forKey:@"SHOW"];
                
            }
            
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            
        }];
        
        
        
//        [self.praiseButton setImage:[UIImage imageNamed:(self.praiseTag%2==0?@"detail_favorite2":@"detail_favorite1")] forState:UIControlStateNormal];
//        self.praiseTag++;
//        CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//        k.values = @[@(0.1),@(1.0),@(1.5)];
//        k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
//        k.calculationMode = kCAAnimationLinear;
//        [self.praiseButton.layer addAnimation:k forKey:@"SHOW"];
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [[self viewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}
- (IBAction)gotoComment:(id)sender {
    if ([self isSignIn]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BBS" bundle:nil];
        WGBBSViewController *vc = [sb instantiateInitialViewController];
        vc.toUserId = _infoModel.userId;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [[self viewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

@end
