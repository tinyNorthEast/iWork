//
//  WGSignUpViewController.m
//  iWork
//
//  Created by Adele on 11/20/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGVertifyPhoneViewController.h"

#import "extobjc.h"
#import <SMS_SDK/SMSSDK.h>

#import "WGProgressHUD.h"
#import "WGCountDownButton.h"

@interface WGVertifyPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet WGCountDownButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation WGVertifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBACtion
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCodeAction:(id)sender {
    if (self.getCodeButton.isCountDowning) {
        return;
    }
    
    [WGProgressHUD loadMessage:@"正在发送验证码..." onView:self.view];
    @weakify(self);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        @strongify(self);
        if (!error) {
            [self.getCodeButton startCountDownTimer];
            [WGProgressHUD autoDisappearWithMessage:@"验证码发送成功" onView:self.view];
        }else{
            [self.getCodeButton stopCountDownTimer];
            [WGProgressHUD autoDisappearWithMessage:@"验证码发送失败" onView:self.view];
        }
    }];
}
- (IBAction)confirmAction:(id)sender {
//    [WGProgressHUD loadMessage:@"正在验证..." onView:self.view];
//    @weakify(self);
//    [SMSSDK commitVerificationCode:self.codeTextField.text phoneNumber:self.phoneTextField.text zone:@"86" result:^(NSError *error) {
//        @strongify(self);
//        if (!error) {
    
            if (self.vertifyView == WGVertifyView_SignUp) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
                UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGSignUpUserInfoViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
                UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGRepeatPasswordViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
   
//        }else{
//            [WGProgressHUD autoDisappearWithMessage:@"请重新检查输入结果" onView:self.view];
//        }
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
