//
//  WGSignInViewController.m
//  iWork
//
//  Created by Adele on 11/20/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignInViewController.h"

#import "WGValidJudge.h"
#import "WGProgressHUD.h"

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
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)sign_upAction:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@""];
//    [self.navigationController pushViewController:vc animated:YES];
    if (![WGValidJudge isValidString:self.phoneTextField.text]) {
        [WGProgressHUD autoDisappearWithMessage:PhoneTextFieldWarning onView:self.view];
    }else if(![WGValidJudge isValidString:self.passwordTextField.text]){
        [WGProgressHUD autoDisappearWithMessage:PasswordTextFieldWarning onView:self.view];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
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
