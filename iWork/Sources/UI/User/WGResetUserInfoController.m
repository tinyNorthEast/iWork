//
//  WGResetUserInfoController.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetUserInfoController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"

#import "WGUserInfoModel.h"
#import "WGResetUserInfoRequest.h"

@interface WGResetUserInfoController()

@property (nonatomic, strong) NSMutableDictionary *infoDic;

@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UITextField *enNameField;
@property (weak, nonatomic) IBOutlet UITextField *experienceField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;

@end

@implementation WGResetUserInfoController

- (void)viewDidLoad{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
    self.mailField.text = self.userInfoModel.mail;
    self.enNameField.text = self.userInfoModel.en_name;
    self.experienceField.text = self.userInfoModel.experience.stringValue;
    self.companyField.text = self.userInfoModel.company;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self hideKeyboard];
}

- (void)hideKeyboard{
//    [self.mailField resignFirstResponder];
//    [self.enNameField resignFirstResponder];
//    [self.experienceField resignFirstResponder];
//    [self.companyField resignFirstResponder];
}
- (void)hideKeyBoard:(UIGestureRecognizer *)recognizer{
    [self hideKeyboard];
}
#pragma mark - Init
- (NSMutableDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic = [NSMutableDictionary dictionary];
    }
    return _infoDic;
}
- (void)setUserInfoModel:(WGUserInfoModel *)userInfoModel{    
    _userInfoModel = userInfoModel;
}

#pragma mark - IBAction
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backAction:(id)sender {
    [self back];
}
- (IBAction)saveAction:(id)sender {
    if (self.mailField.text.length && ![self.mailField.text isEqualToString:self.userInfoModel.mail]) {
        [self.infoDic setObject:self.mailField.text forKey:@"mail"];
    }
    if (self.enNameField.text.length && ![self.enNameField.text isEqualToString:self.userInfoModel.en_name]) {
        [self.infoDic setObject:self.enNameField.text forKey:@"en_name"];
    }
    if (self.experienceField.text.length && ![self.experienceField.text isEqualToString:self.userInfoModel.experience.stringValue]) {
        [self.infoDic setObject:self.experienceField.text forKey:@"experience"];
    }
    if (self.companyField.text.length && ![self.companyField.text isEqualToString:self.userInfoModel.company]) {
        [self.infoDic setObject:self.companyField.text forKey:@"company"];
    }
    
    if (self.infoDic.allKeys.count == 0) {
        [self back];
        return;
    }
    
    WGResetUserInfoRequest *request = [[WGResetUserInfoRequest alloc] initWithUserInfo:self.infoDic];
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        if (baseModel.infoCode.integerValue == 0) {
            [self back];
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
