//
//  WGResetUserInfoController.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetUserInfoController.h"

#import "WGUserInfoModel.h"

@interface WGResetUserInfoController()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UITextField *enNameField;
@property (weak, nonatomic) IBOutlet UITextField *experienceField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;

@end

@implementation WGResetUserInfoController

- (void)viewDidLoad{
    self.passwordField.text = self.userInfoModel.password;
    self.mailField.text = self.userInfoModel.mail;
    self.enNameField.text = self.userInfoModel.en_name;
    self.experienceField.text = self.userInfoModel.experience.stringValue;
    self.companyField.text = self.userInfoModel.company;
}

- (void)setUserInfoModel:(WGUserInfoModel *)userInfoModel{    
    _userInfoModel = userInfoModel;
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveAction:(id)sender {
    
}


@end
