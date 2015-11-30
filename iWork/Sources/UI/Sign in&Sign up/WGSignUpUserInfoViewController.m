//
//  WGSignUpUserInfoViewController.m
//  iWork
//
//  Created by Adele on 11/26/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpUserInfoViewController.h"

#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "NSMutableDictionary+WGExtension.h"
#import "WGSignUpWorkInfoViewController.h"

@interface WGSignUpUserInfoViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@end

@implementation WGSignUpUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
- (NSMutableDictionary *)userInfoDict{
    if (!_userInfoDict) {
        _userInfoDict = [NSMutableDictionary dictionary];
    }
    return _userInfoDict;
}

#pragma mark - IBACtion
- (IBAction)addPhotoAction:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择",nil];
    [as showInView:self.view];
}
- (IBAction)nextAction:(id)sender {
    if (![WGValidJudge isValidString:self.userNameTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写姓名" onView:self.view];
        return;
    }if (![WGValidJudge isValidString:self.emailTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写邮箱" onView:self.view];
        return;
    }
    
    [self.userInfoDict safeSetValue:self.userNameTextField.text forKey:@"zh_name"];
    [self.userInfoDict safeSetValue:self.userNameTextField.text forKey:@"zh_name"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    WGSignUpWorkInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGSignUpWorkInfoViewController"];
    vc.workInfoDict = self.userInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
