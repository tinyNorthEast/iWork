//
//  WGResetUserInfoController.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResetUserInfoController.h"

#import <extobjc.h>

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
    self.mailField.text = self.userInfoModel.mail;
    self.enNameField.text = self.userInfoModel.en_name;
    self.experienceField.text = self.userInfoModel.experience.stringValue;
    self.companyField.text = self.userInfoModel.company;
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
    WGResetUserInfoRequest *request = [[WGResetUserInfoRequest alloc] initWithUserInfo:self.infoDic];
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
    
}


@end
