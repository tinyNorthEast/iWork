//
//  WGSignInViewController.m
//  iWork
//
//  Created by Adele on 11/20/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignInViewController.h"

#import <extobjc.h>
#import "APService.h"

#import "SignHeader.h"
#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "WGSignInRequest.h"
#import "WGSignInRequestModel.h"
#import "WGSignInModel.h"
#import "WGVertifyPhoneViewController.h"

#import "WGGlobal.h"

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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    //set default phone
    if ([[WGGlobal sharedInstance] defaultPhone].length) {
        self.phoneTextField.text = [[WGGlobal sharedInstance] defaultPhone];
    }
    //hide keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideKeyboard:(UIGestureRecognizer *)gesture{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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
        [WGProgressHUD loadMessage:@"正在登录..." onView:self.view];
        WGSignInRequest *request = [[WGSignInRequest alloc] initWithPhone:self.phoneTextField.text password:self.passwordTextField.text];
        
        @weakify(self);
        [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
            @strongify(self);
            WGSignInRequestModel *model = (WGSignInRequestModel *)baseModel;
            if (model.infoCode.integerValue==0) {
                [WGProgressHUD disappearSuccessMessage:@"登录成功" onView:self.view];
                
                
                
                //保存电话号码
                [[WGGlobal sharedInstance] saveDefaultPhone:self.phoneTextField.text];
                
                //
                WGSignInModel *signInModel = model.data;
                
                [[WGGlobal sharedInstance] saveSignInfo:[model.data toDictionary]];
                
                //设置极光别名
                [APService setAlias:signInModel.userId.stringValue callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                
                [[WGGlobal sharedInstance] saveToken:signInModel.token];
                [self back];
            }else{
                [WGProgressHUD disappearFailureMessage:model.message onView:self.view];
            }
        } failure:^(WGBaseModel *baseModel, NSError *error) {
            [WGProgressHUD disappearSuccessMessage:@"登录失败,请检查网络设置" onView:self.view];
        }];
    }
}
-(void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias{
     NSLog(@"-----------alias success----------");
}
#pragma mark - NSNotification
- (void)textFieldBeginEditing:(NSNotification *)notification{
    if (self.phoneTextField.text.length >= 11 && self.passwordTextField.text.length>kMIN_PASSWORD_LEGTH){
        [self.sign_inButton setEnabled:YES];
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1) {
        if (textField.text.length>=11 && range.length ==0) {
            return NO;
        }
    }else{
        if (textField.text.length>=kMAX_PASSWORD_LEGTH && range.length == 0) {
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
