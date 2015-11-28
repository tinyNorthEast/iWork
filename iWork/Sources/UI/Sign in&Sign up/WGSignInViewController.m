//
//  WGSignInViewController.m
//  iWork
//
//  Created by Adele on 11/20/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignInViewController.h"

#import <extobjc.h>

#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "WGSignInRequest.h"
#import "WGVertifyPhoneViewController.h"

NSString *PhoneTextFieldWarning = @"请填写用户名";
NSString *PasswordTextFieldWarning = @"请填写密码";

@interface WGSignInViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *sign_inButton;

@end

@implementation WGSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBACtion
- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)backAction:(id)sender {
    [self back];
}
- (IBAction)sign_upAction:(id)sender {
    if (![WGValidJudge isValidString:self.phoneTextField.text]) {
        [WGProgressHUD autoDisappearWithMessage:PhoneTextFieldWarning onView:self.view];
    }else if(![WGValidJudge isValidString:self.passwordTextField.text]){
        [WGProgressHUD autoDisappearWithMessage:PasswordTextFieldWarning onView:self.view];
    }else{
        WGSignInRequest *request = [[WGSignInRequest alloc] initWithPhone:self.phoneTextField.text password:self.passwordTextField.text];
        
        @weakify(self);
        [request requestWithSuccess:^(WGBaseModel *model, NSURLSessionTask *task) {
            @strongify(self);
            [self back];
            
        } failure:^(NSError *error, NSURLSessionTask *task) {
            
        }];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WGVertifyPhoneViewController *vc = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"SignUp"]) {
        vc.vertifyView = WGVertifyView_SignUp;
    }else{
        vc.vertifyView = WGVertifyView_GetPassword;
    }
}

@end
