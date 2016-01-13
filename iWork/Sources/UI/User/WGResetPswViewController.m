//
//  WGResetPswViewController.m
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetPswViewController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"
#import "WGResetPasswordRequest.h"
#import "WGBaseModel.h"

@interface WGResetPswViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPswField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPswField;

@end

@implementation WGResetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.-
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    if (self.oldPswField.text.length == 0) {
        [WGProgressHUD disappearFailureMessage:@"请输入旧密码" onView:self.view];
    }else if(self.pswField.text.length == 0){
        [WGProgressHUD disappearFailureMessage:@"请输人新密码" onView:self.view];
    }else if(self.confirmPswField.text.length == 0){
        [WGProgressHUD disappearFailureMessage:@"请确认新密码" onView:self.view];
    }else if(![self.pswField.text isEqualToString:self.confirmPswField.text]){
        [WGProgressHUD disappearFailureMessage:@"新密码不一致" onView:self.view];
    }else{
        [WGProgressHUD defaultLoadingOnView:self.view];
        WGResetPasswordRequest *requst = [[WGResetPasswordRequest alloc] initWithOldPassword:self.oldPswField.text newPassword:self.pswField.text];
        @weakify(self);
        [requst requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            [WGProgressHUD dismissOnView:self.view];
            if (baseModel.infoCode.integerValue == TokenFailed) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
                UIViewController *vc = [sb instantiateInitialViewController];
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
            }
            else if (baseModel.infoCode.integerValue == 0) {
                
            }else{
                [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
            }
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            [WGProgressHUD disappearFailureMessage:@"加载失败" onView:self.view];
        }];
    }
}

@end
