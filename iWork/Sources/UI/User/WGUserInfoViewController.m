//
//  WGUserInfoViewController.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGUserInfoViewController.h"

#import <extobjc.h>
#import "M13BadgeView.h"

#import "UIViewAdditions.h"
#import "UIImageView+WGHTTP.h"
#import "WGGlobal.h"
#import "SignHeader.h"
#import "UIColor+WGThemeColors.h"

#import "WGUserInfoRequest.h"
#import "WGUserInfoRequestModel.h"
#import "WGUserInfoModel.h"
#import "WGResetUserInfoController.h"
#import "WGFavoriteListController.h"
#import "WGSignInModel.h"

@interface WGUserInfoViewController ()
@property (nonatomic, strong) WGUserInfoModel *userInfoModel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *myNotifiLabel;

@end

@implementation WGUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchUserInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init
- (void)initView{
    NSNumber *role = [[WGGlobal sharedInstance] signInfo].role_code;
    switch (role.integerValue) {
        case kkUserRole_headhunters:
            self.titleLabel.text = @"猎头";
            break;
            
        case kkUserRole_candidate:
            self.titleLabel.text = @"候选人";
            
            break;
        case kkUserRole_HR:
            self.titleLabel.text = @"企业HR";
            
            break;
            
            break;
        default:
            break;
    }
}
#pragma mark - Request
- (void)fetchUserInfo{
    WGUserInfoRequest *request = [[WGUserInfoRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == 0) {
            WGUserInfoRequestModel *model = (WGUserInfoRequestModel *)baseModel;
            WGUserInfoModel *infoModel = model.data;
            
            self.userInfoModel = infoModel;
            
            [self.headerImage wg_loadImageFromURL:infoModel.pic placeholder:[UIImage imageNamed:@"user_defaultHeader"]];
            [self.nameLabel setText:infoModel.zh_name];
            
            M13BadgeView *badgeView = [[M13BadgeView alloc] initWithFrame:CGRectMake(self.myNotifiLabel.right, 12, 24.0, 24.0)];
            [self.myNotifiLabel addSubview:badgeView];
            badgeView.text = infoModel.noticeCount.stringValue;
            badgeView.badgeBackgroundColor = [UIColor wg_themeCyanColor];
            badgeView.hidesWhenZero = YES;
        }   
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}
#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)gotoSettingAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ResetInfo"]) {
        WGResetUserInfoController *vc = [segue destinationViewController];
        vc.userInfoModel = self.userInfoModel;
    }else if ([segue.identifier isEqualToString:@"MyFocus"]) {
        WGFavoriteListController *vc = [segue destinationViewController];
        vc.searchType = FavoriteSearch_To;
    }else if ([segue.identifier isEqualToString:@"OthersFocus"]) {
        WGFavoriteListController *vc = [segue destinationViewController];
        vc.searchType = FavoriteSearch_From;
    }
}

@end
