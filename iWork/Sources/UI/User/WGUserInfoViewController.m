//
//  WGUserInfoViewController.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGUserInfoViewController.h"

#import <extobjc.h>
#import "UIImageView+WGHTTP.h"
#import "WGGlobal.h"
#import "SignHeader.h"

#import "WGUserInfoRequest.h"
#import "WGUserInfoRequestModel.h"
#import "WGUserInfoModel.h"
#import "WGResetUserInfoController.h"

@interface WGUserInfoViewController ()
@property (nonatomic, strong) WGUserInfoModel *userInfoModel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WGUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchUserInfo];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init
- (void)initView{
    NSNumber *role = [[WGGlobal sharedInstance] userRole];
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
        WGUserInfoRequestModel *model = (WGUserInfoRequestModel *)baseModel;
        WGUserInfoModel *infoModel = model.data;
        
        self.userInfoModel = infoModel;
        
        [self.headerImage wg_loadImageFromURL:infoModel.pic placeholder:[UIImage imageNamed:@"user_defaultHeader"]];
        [self.nameLabel setText:infoModel.zh_name];
        
        
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
    WGResetUserInfoController *vc = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"ResetInfo"]) {
        vc.userInfoModel = self.userInfoModel;
    }
}

@end
