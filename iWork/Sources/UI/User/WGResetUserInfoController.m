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

- (void)setUserInfoModel:(WGUserInfoModel *)userInfoModel{
    self.passwordField.text = userInfoModel.password;
    self.mailField.text = userInfoModel.mail;
    self.enNameField.text = userInfoModel.en_name;
    self.experienceField.text = userInfoModel.experience.stringValue;
    self.companyField.text = userInfoModel.company;
}

@end
