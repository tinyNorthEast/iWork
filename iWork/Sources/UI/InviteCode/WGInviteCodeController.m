//
//  WGInviteCodeController.m
//  iWork
//
//  Created by Adele on 12/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGInviteCodeController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"
#import "UIColor+WGThemeColors.h"

#import "WGCodeRequest.h"
#import "WGCodeListModel.h"
#import "WGCodeModel.h"

@interface WGInviteCodeController ()<UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *code1;
//@property (weak, nonatomic) IBOutlet UILabel *code2;


@property (weak, nonatomic) IBOutlet UITextField *code1;
@property (weak, nonatomic) IBOutlet UITextField *code2;


@end

@implementation WGInviteCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.code1.hidden = YES;
    self.code2.hidden = YES;
    [self getCodesRequest];
    
    [self.code1 canPerformAction:@selector(copy) withSender:nil];
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request
- (void)setupCodeLabel:(NSArray *)codes{
    for (int index=0; index<codes.count; index++) {
        WGCodeModel *model = codes[index];
        if (index == 0) {
            self.code1.hidden = NO;
            
            if (model.status.integerValue == 0) {
                self.code1.textColor = [UIColor wg_themeGrayColor];
                self.code1.text = [NSString stringWithFormat:@"%@(不可用)",model.code];
            }else{
                self.code1.textColor = [UIColor wg_themeBlackColor];
                self.code1.text = [NSString stringWithFormat:@"%@(可用)",model.code];
            }
            
        }else if (index == 1){
            self.code2.hidden = NO;
            
            if (model.status.integerValue == 0) {
                self.code2.textColor = [UIColor wg_themeGrayColor];
                self.code2.text = [NSString stringWithFormat:@"%@(不可用)",model.code];
            }else{
                self.code2.textColor = [UIColor wg_themeBlackColor];
                self.code2.text = [NSString stringWithFormat:@"%@(可用)",model.code];
            }
        }
    }
}
- (void)getCodesRequest{
    WGCodeRequest *request = [[WGCodeRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue==0) {
            WGCodeListModel *model = (WGCodeListModel *)baseModel;
            [self setupCodeLabel:model.data];
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
