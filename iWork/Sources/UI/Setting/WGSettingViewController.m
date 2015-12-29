//
//  WGSettingViewController.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSettingViewController.h"

#import "WGProgressHUD.h"

#import "WGGlobal.h"

NS_ENUM(NSInteger,WGSettingAlertTag){
    WGSettingAlertTag_SignOut = 1,
    WGSettingAlertTag_Clear
};

@interface WGSettingViewController ()<UIAlertViewDelegate>

@end

@implementation WGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNaviBar{
    self.navigationItem.title = @"设置";
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:[UIImage imageNamed:@"navi_back.png"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithCustomView:bt];
    self.navigationItem.leftBarButtonItem=leftButton;
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)switchNotification:(UISwitch *)sender {
    if (sender.on) {
        [WGProgressHUD disappearSuccessMessage:@"打开推送" onView:self.view];
    }else{
        [WGProgressHUD disappearSuccessMessage:@"关闭推送" onView:self.view];
    }
}
- (IBAction)signOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确认退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = WGSettingAlertTag_SignOut;
    [alert show];
}

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小为%f.确定要删除缓存吗?",@(5.9)] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (indexPath.row == 3){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"About" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case WGSettingAlertTag_SignOut:
        {
            if (buttonIndex == 1) {
                [self dismissViewControllerAnimated:YES completion:^{
                    [[WGGlobal sharedInstance] clearUserInfo];
                }];
            }
        }
            break;
            
        case WGSettingAlertTag_Clear:
        {
            
        }
            break;
    }
}

@end
