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

#import "WGGlobal.h"
#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "WGCountDownButton.h"
#import "NSMutableDictionary+WGExtension.h"
#import "WGSignUpUserInfoViewController.h"
#import "WGRepeatPasswordViewController.h"

@interface WGVertifyPhoneViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet WGCountDownButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation WGVertifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if ([[WGGlobal sharedInstance] defaultPhone].length) {
        self.phoneTextField.text = [[WGGlobal sharedInstance] defaultPhone];
    }
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
    if ([WGValidJudge isValidPhoneNum:self.phoneTextField.text]) {
        
    }
    if (![WGValidJudge isValidString:self.phoneTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写电话号码" onView:self.view];
        return;
    }
    if (self.getCodeButton.isCountDowning) {
        return;
    }
    [WGProgressHUD loadMessage:@"正在发送验证码..." onView:self.view];
    @weakify(self);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        @strongify(self);
        if (!error) {
            [self.getCodeButton startCountDownTimer];
            [WGProgressHUD disappearSuccessMessage:@"验证码发送成功" onView:self.view];
        }else{
            [self.getCodeButton stopCountDownTimer];
            [WGProgressHUD disappearFailureMessage:@"验证码发送失败" onView:self.view];
        }
    }];
}
- (IBAction)confirmAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    WGSignUpUserInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGSignUpUserInfoViewController"];
    [vc.userInfoDict safeSetValue:self.phoneTextField.text forKey:@"phone"];
    [self.navigationController pushViewController:vc animated:YES];
//    if (![WGValidJudge isValidString:self.phoneTextField.text]) {
//        [WGProgressHUD disappearFailureMessage:@"请先填写电话号码" onView:self.view];
//        return;
//    }
//    if(![WGValidJudge isValidPhoneNum:self.phoneTextField.text]){
//        [WGProgressHUD disappearFailureMessage:@"请填写正确的电话号码" onView:self.view];
//        return;
//    }
//    if (![WGValidJudge isValidString:self.codeTextField.text]) {
//        [WGProgressHUD disappearFailureMessage:@"请先填写验证码" onView:self.view];
//        return;
//    }
//    [WGProgressHUD loadMessage:@"正在验证..." onView:self.view];
//    @weakify(self);
//    [SMSSDK commitVerificationCode:self.codeTextField.text phoneNumber:self.phoneTextField.text zone:@"86" result:^(NSError *error) {
//        @strongify(self);
//        if (!error) {
//            [WGProgressHUD dismissOnView:self.view];
//            if (self.vertifyView == WGVertifyView_SignUp) {
//                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
//                WGSignUpUserInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGSignUpUserInfoViewController"];
//                [vc.userInfoDict safeSetValue:self.phoneTextField.text forKey:@"phone"];
//                [self.navigationController pushViewController:vc animated:YES];
//            }else{
//                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
//                WGRepeatPasswordViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGRepeatPasswordViewController"];
//                vc.viewFounction = WGViewFounction_ResetPassword;
//                vc.phoneStr = self.phoneTextField.text;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }else{
//            [WGProgressHUD disappearFailureMessage:@"请重新检查输入结果" onView:self.view];
//        }
//    }];
}
#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1) {
        if (textField.text.length>=11) {
            return NO;
        }
    }else{
        if (textField.text.length>=4) {
            return NO;
        }
    }
    return YES;
}

@end
