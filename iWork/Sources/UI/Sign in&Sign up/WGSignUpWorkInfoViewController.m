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

@interface WGSignUpWorkInfoViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (strong, nonatomic) WGDataPickerView *picker;

@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UITextField *experienceTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *roleTextField;

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

- (WGDataPickerView *)picker{
    if (!_picker) {
        _picker = [[WGDataPickerView alloc] initWithFrame:self.view.bounds];
        _picker.autoHidden = YES;
        [_picker setSelectIndex:0];
        [_picker showInView:self.view];
    }
    return _picker;
}

#pragma mark - IBACtion
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)popExperienceView:(id)sender {

    self.picker.dataArray = @[@"3年以下", @"3-5年", @"5-10年",@"10年以上"];
    self.picker.barTitle = @"工作经验";
    
    @weakify(self);
    [self.picker showSelectDate:^(NSInteger selectRow) {
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
        
        self.experienceTextFiled.text = self.picker.dataArray[selectRow];
        [self.workInfoDict safeSetValue:@(exID) forKey:@"experience"];
        
    } cancel:^{
        
    }];
}
- (IBAction)popRoleView:(id)sender {
    
    self.picker.dataArray = @[@"猎头顾问", @"企业HR", @"候选人"];
    self.picker.barTitle = @"工作经验";
    
    @weakify(self);
    [self.picker showSelectDate:^(NSInteger selectRow) {
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
        self.roleTextField.text = self.picker.dataArray[selectRow];
        [self.workInfoDict safeSetValue:@(roleID) forKey:@"role_code"];
        
    } cancel:^{
        
    }];
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
    [self.workInfoDict safeSetValue:self.experienceTextFiled.text forKey:@"experience"];
    [self.workInfoDict safeSetValue:self.roleTextField.text forKey:@"role_code"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    WGRepeatPasswordViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGRepeatPasswordViewController"];
    vc.viewFounction = WGViewFounction_SignUp;
    vc.signUpInfoDict = self.workInfoDict;
    [self.navigationController pushViewController:vc animated:YES];
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
