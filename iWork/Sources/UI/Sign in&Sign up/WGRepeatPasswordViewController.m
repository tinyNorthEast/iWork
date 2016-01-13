//
//  WGRepeatPasswordViewController.m
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGRepeatPasswordViewController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"
#import "WGValidJudge.h"
#import "WGSignUpRequest.h"
#import "NSMutableDictionary+WGExtension.h"
#import "NSString+WGExtension.h"
#import "WGForgetPasswordRequest.h"
#import "WGSignUpRequestModel.h"
#import "WGSignUpModel.h"
#import "WGGlobal.h"

@interface WGRepeatPasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation WGRepeatPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewFounction == WGViewFounction_SignUp) {
       self.passwordTextField.placeholder = @"请输入密码";
    }else{
        self.passwordTextField.placeholder = @"重置密码";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init
- (NSMutableDictionary *)signUpInfoDict{
    if (!_signUpInfoDict) {
        _signUpInfoDict = [NSMutableDictionary dictionary];
    }
    return _signUpInfoDict;
}
#pragma mark - IBACtion
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)backAction:(id)sender {
    [self back];
}
- (IBAction)doneAction:(id)sender {
    if (![WGValidJudge isValidString:self.passwordTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请设置密码" onView:self.view];
        return;
    }if (![WGValidJudge isValidString:self.repeatTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请确认密码" onView:self.view];
        return;
    }if (![self.repeatTextField.text isEqualToString:self.repeatTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"两次密码不相同" onView:self.view];
        return;
    }
    
    if (self.viewFounction == WGViewFounction_SignUp) {
        [self.signUpInfoDict safeSetValue:[[NSString stringDecodingByMD5:self.passwordTextField.text] lowercaseString] forKey:@"password"];
       
        [WGProgressHUD defaultLoadingOnView:self.view];
        WGSignUpRequest *request = [[WGSignUpRequest alloc] initWithInfo:self.signUpInfoDict];
         @weakify(self);
        [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            if (baseModel.infoCode.integerValue == 0) {
                [WGProgressHUD dismissOnView:self.view];
                [self back];
            }else{
                [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
            }
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            [WGProgressHUD disappearFailureMessage:@"注册失败" onView:self.view];
            
        }];
    }else{
        @weakify(self);
        [WGProgressHUD defaultLoadingOnView:self.view];
        WGForgetPasswordRequest *request = [[WGForgetPasswordRequest alloc] initWithPhone:self.phoneStr password:self.passwordTextField.text];
        [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            if (baseModel.infoCode.integerValue == 0) {
                [WGProgressHUD dismissOnView:self.view];
                [self back];
            }else{
                [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
            }
            
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            [WGProgressHUD disappearFailureMessage:@"重置密码失败" onView:self.view];
        }];
    }
}

@end
