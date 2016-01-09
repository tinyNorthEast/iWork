//
//  WGSignUpWorkInfoViewController.m
//  iWork
//
//  Created by Adele on 11/26/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpWorkInfoViewController.h"

#import <extobjc.h>

#import "WGValidJudge.h"
#import "WGProgressHUD.h"
#import "UIViewAdditions.h"
#import "WGDataPickerView.h"
#import "NSMutableDictionary+WGExtension.h"
#import "WGRepeatPasswordViewController.h"

@interface WGSignUpWorkInfoViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) WGDataPickerView *exPicker;
@property (strong, nonatomic) WGDataPickerView *rolePicker;

@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UITextField *experienceTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *roleTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation WGSignUpWorkInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
- (NSMutableDictionary *)workInfoDict{
    if (!_workInfoDict) {
        _workInfoDict = [NSMutableDictionary dictionary];
    }
    return _workInfoDict;
}

- (WGDataPickerView *)exPicker{
    if (!_exPicker) {
        _exPicker = [[WGDataPickerView alloc] initWithFrame:self.view.bounds];
        _exPicker.autoHidden = NO;
        [_exPicker setSelectIndex:0];
        [_exPicker showInView:self.view];
    }
    return _exPicker;
}
- (WGDataPickerView *)rolePicker{
    if (!_rolePicker) {
        _rolePicker = [[WGDataPickerView alloc] initWithFrame:self.view.bounds];
        _rolePicker.autoHidden = NO;
        [_rolePicker setSelectIndex:0];
        [_rolePicker showInView:self.view];
    }
    return _rolePicker;
}

#pragma mark - IBACtion
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)popExperienceView:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideKeyboard];
        if (self.experienceTextFiled.resignFirstResponder) {
            [self.experienceTextFiled resignFirstResponder];
        }
    });

    self.exPicker = [[WGDataPickerView alloc] initWithFrame:self.view.bounds];
    
    self.exPicker.dataArray = @[@"3年以下", @"3-5年", @"5-10年",@"10年以上"];
    self.exPicker.barTitle = @"工作经验";
    
    @weakify(self);
    [self.exPicker showSelectDate:^(NSInteger selectRow) {
        @strongify(self);
        NSInteger exID = 0;
        switch (selectRow) {
            case 0:
                exID = 1;
                break;
                
            case 1:
                exID = 2;
                break;
                
            case 2:
                exID = 3;
                break;
                
            case 3:
                exID = 4;
                break;
        }
        
        self.experienceTextFiled.text = self.exPicker.dataArray[selectRow];
        [self.workInfoDict safeSetValue:@(exID) forKey:@"experience"];
        
    } cancel:^{
        
    }];
    
    [self.exPicker showInView:self.view];
}
- (IBAction)popRoleView:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideKeyboard];
        if (self.roleTextField.resignFirstResponder) {
            [self.roleTextField resignFirstResponder];
        }
    });
    
    self.rolePicker = [[WGDataPickerView alloc] initWithFrame:self.view.bounds];
    self.rolePicker.dataArray = @[@"猎头顾问", @"企业HR", @"候选人"];
    self.rolePicker.barTitle = @"工作经验";
    
    @weakify(self);
    [self.rolePicker showSelectDate:^(NSInteger selectRow) {
        @strongify(self);
        NSInteger roleID = 0;
        switch (selectRow) {
            case 0:
                roleID = 100;
                break;
                
            case 1:
                roleID = 101;
                break;
                
            case 2:
                roleID = 102;
                break;
        }
        self.roleTextField.text = self.rolePicker.dataArray[selectRow];
        [self.workInfoDict safeSetValue:@(roleID) forKey:@"role_code"];
        
    } cancel:^{
        
    }];
    [self.rolePicker showInView:self.view];
}

- (IBAction)nextAction:(id)sender {
    if (![WGValidJudge isValidString:self.positionTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写职业信息" onView:self.view];
        return;
    }if (![WGValidJudge isValidString:self.experienceTextFiled.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写从业经验" onView:self.view];
        return;
    }if (![WGValidJudge isValidString:self.roleTextField.text]) {
        [WGProgressHUD disappearFailureMessage:@"请填写身份信息" onView:self.view];
        return;
    }
    
    [self.workInfoDict safeSetValue:self.positionTextField.text forKey:@"position"];
    [self.workInfoDict safeSetValue:self.codeTextField.text forKey:@"invate_code"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    WGRepeatPasswordViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGRepeatPasswordViewController"];
    vc.viewFounction = WGViewFounction_SignUp;
    vc.signUpInfoDict = self.workInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)hideKeyboard{
    if (self.positionTextField.resignFirstResponder) {
        [self.positionTextField resignFirstResponder];
    }
    if (self.codeTextField.resignFirstResponder) {
        [self.codeTextField resignFirstResponder];
    }
}
- (IBAction)tapBackground:(id)sender {
    [self hideKeyboard];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - UITextFieldDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
