//
//  WGDetailHeaderView.m
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDetailHeaderView.h"

#import <XXNibBridge.h>

#import "UIViewAdditions.h"
#import "UIImageView+WGHTTP.h"

#import "WGGlobal.h"
#import "WGHunterInfoModel.h"
#import "WGHunterDetailViewController.h"
#import "WGBBSViewController.h"

@interface WGDetailHeaderView()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation WGDetailHeaderView

#pragma mark - Init
- (void)setInfoModel:(WGHunterInfoModel *)infoModel{
    [self.headerImage wg_loadImageFromURL:infoModel.pic placeholder:[UIImage imageNamed:@"detail_defaultHeader"]];
    self.nameLabel.text = infoModel.realName;
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
        WGBBSViewController *vc = [sb instantiateInitialViewController];;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [[self viewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
