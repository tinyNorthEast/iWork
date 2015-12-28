//
//  WGSettingViewController.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSettingViewController.h"

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
    
    self.navigationItem.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)switchNotification:(UISwitch *)sender {
    if (sender.on) {
        
    }else{
        
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
