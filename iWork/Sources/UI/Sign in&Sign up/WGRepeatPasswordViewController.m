//
//  WGRepeatPasswordViewController.m
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGRepeatPasswordViewController.h"

#import "WGProgressHUD.h"
#import "WGValidJudge.h"
#import "NSMutableDictionary+WGExtension.h"
#import "WGSignUpRequest.h"
#import "NSString+WGMD5.h"

@interface WGRepeatPasswordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation WGRepeatPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    
    [self.signUpInfoDict safeSetValue:[[NSString stringDecodingByMD5:self.passwordTextField.text] lowercaseString] forKey:@"password"];
    
    WGSignUpRequest *request = [[WGSignUpRequest alloc] initWithInfo:self.signUpInfoDict];
    
    [request requestWithSuccess:^(WGBaseModel *model, NSError *error) {
        
    } failure:^(WGBaseModel *model, NSError *error) {
        
    }];
    
//    [self back];
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
