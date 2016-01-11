//
//  WGResultsView.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResultsView.h"

#import <XXNibBridge.h>

#import "WGProgressHUD.h"
#import "UIViewAdditions.h"
#import "UIFont+WGThemeFonts.h"
#import "UIColor+WGThemeColors.h"
#import "NSString+WGExtension.h"

#import "WGGlobal.h"
#import "WGResultModel.h"
#import "WGApplyAuthRequest.h"
#import "WGSignInModel.h"

@interface WGResultsView()<XXNibBridge,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UIButton *permissionButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;

@end

@implementation WGResultsView

- (CGFloat)viewHeightbyResultsArray:(NSArray *)results{
    int height = 0;
    int line = 0;
    
    for (int i = 0; i< results.count; i++) {
        NSDictionary *dic = results[i];
        
        height += 20;
        line +=i;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, line, 10, 10)];
        imageView.image = [UIImage imageNamed:@"bbs_timeicon"];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right, imageView.top, 100, 20)];
        timeLabel.centerY = imageView.centerY;
        timeLabel.font = [UIFont kFontSize14];
        timeLabel.textColor = [UIColor wg_themeLightGrayColor];
        timeLabel.text = dic[@"groupDate"];
        [self.resultView addSubview:imageView];
        [self.resultView addSubview:timeLabel];
        
        NSArray *lists = dic[@"list"];
        for (int x = 0; x < lists.count; x++) {
            WGResultModel *resultModel = [[WGResultModel alloc] initWithDictionary:lists[i] error:nil];
            line += x+1;
            UILabel *compayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (x+1)*20, (self.resultView.width-10)*2/5, 20)];
            compayLabel.text = resultModel.companyName;
            compayLabel.font = [UIFont kFontSize14];
            compayLabel.textColor = [UIColor wg_themeDarkGrayColor];
            [self.resultView addSubview:compayLabel];
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(compayLabel.right, compayLabel.top, (self.resultView.width-10)*1.6/5, 20)];
            positionLabel.font = [UIFont kFontSize14];
            positionLabel.textColor = [UIColor wg_themeDarkGrayColor];
            positionLabel.text = resultModel.position;
            [self.resultView addSubview:positionLabel];
            
            UILabel *salaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionLabel.right, compayLabel.top, (self.resultView.width-10)*1.4/5, 20)];
            salaryLabel.font = [UIFont kFontSize14];
            salaryLabel.textColor = [UIColor wg_themeDarkGrayColor];
            salaryLabel.textAlignment = NSTextAlignmentRight;
            salaryLabel.text = [NSString stringWithFormat:@"%@万/年薪",resultModel.annualSalary];
            [self.resultView addSubview:salaryLabel];
            
            height += 20*(x+1);
        }
    }
    self.resultViewHeight.constant = height;
    
    if ([WGGlobal sharedInstance].signInfo.role_code.integerValue == UserRole_HR) {
        self.buttonHeight.constant = 45;
        [self.permissionButton setHidden:NO];
        return 50+height+70;
    }
    else{
        self.buttonHeight.constant = 0;
        [self.permissionButton setHidden:YES];
        return 50+height;
    }
}

#pragma mark - IBAcion
- (BOOL)isSignIn{
    return ([[WGGlobal sharedInstance] userToken].length>0?YES:NO);
}
- (IBAction)openPermission:(id)sender {
    if ([self isSignIn]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请核对邮箱" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"正确", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        UITextField *textField  = [alert textFieldAtIndex:0];
        textField.text = [WGGlobal sharedInstance].signInfo.mail;
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        
        [alert show];
        
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [[self viewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        UITextField *textField  = [alertView textFieldAtIndex:0];
        if (![NSString isValidEmail:textField.text]) {
            [WGProgressHUD disappearFailureMessage:@"请输入正确邮箱" onView:self.viewController.view];
        }else{
            [WGProgressHUD loadMessage:@"正在帮你申请权限" onView:[self viewController].view];
            WGApplyAuthRequest *request = [[WGApplyAuthRequest alloc] initWithHunterId:self.objId hr_mail:textField.text];
            [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
                if (baseModel.infoCode.integerValue == 0) {
                    [WGProgressHUD disappearSuccessMessage:@"发送申请成功" onView:
                     self.viewController.view];
                   
                }else{
                    [WGProgressHUD disappearFailureMessage:baseModel.message onView:[self viewController].view];
                }
            } failure:^(WGBaseModel *baseModel, NSError *error) {
                
            }];
        }
    }
}

@end
