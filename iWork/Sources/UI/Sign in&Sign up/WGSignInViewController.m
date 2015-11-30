//
//  WGSignInViewController.m
//  iWork
//
//  Created by Adele on 11/20/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignInViewController.h"

#import <extobjc.h>

#import "SignHeader.h"
#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "WGSignInRequest.h"
#import "WGVertifyPhoneViewController.h"

NSString *PhoneNoneWarning = @"请填写用户名";
NSString *PhoneWrongWarning = @"请填写正确的电话号码";
NSString *PasswordNoneWarning = @"请填写密码";

@interface WGSignInViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *sign_inButton;

@end

@implementation WGSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        [WGProgressHUD disappearFailureMessage:PhoneNoneWarning onView:self.view];
    }else if(![WGValidJudge isValidPhoneNum:self.phoneTextField.text]){
        [WGProgressHUD disappearFailureMessage:PhoneWrongWarning onView:self.view];
    }else if(![WGValidJudge isValidString:self.passwordTextField.text]){
        [WGProgressHUD disappearFailureMessage:PasswordNoneWarning onView:self.view];
    }else{
        WGSignInRequest *request = [[WGSignInRequest alloc] initWithPhone:self.phoneTextField.text password:self.passwordTextField.text];
        
        @weakify(self);
        [request requestWithSuccess:^(WGBaseModel *model, NSError *error) {
            @strongify(self);
            [self back];
        } failure:^(WGBaseModel *model, NSError *error) {
            
        }];
    }
}

#pragma mark - NSNotification
//- (void)textFieldChange:(NSNotification *)notification{
//    if (self.phoneTextField.text.length == 11 && self.passwordTextField.text.length>MINPASSWORDLEGTH){
//        [self.sign_inButton setEnabled:YES];
//    }
//}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1) {
        if (textField.text.length>=11) {
            return NO;
        }
    }else{
        if (textField.text.length>=kMAX_PASSWORD_LEGTH) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WGVertifyPhoneViewController *vc = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"SignUp"]) {
        vc.vertifyView = WGVertifyView_SignUp;
    }else{
        vc.vertifyView = WGVertifyView_GetPassword;
    }
}

@end
