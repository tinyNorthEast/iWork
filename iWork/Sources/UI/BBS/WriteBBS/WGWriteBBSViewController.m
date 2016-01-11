//
//  WGWriteBBSViewController.m
//  iWork
//
//  Created by Adele on 12/21/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGWriteBBSViewController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"

#import "WGWriteBBSRequest.h"

#define TEXTNUM_MAX 140

@interface WGWriteBBSViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *holderLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *textNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WGWriteBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.naviTitle;
    self.textNumLabel.text = [NSString stringWithFormat:@"可输入%lu字",(unsigned long)TEXTNUM_MAX];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backAction:(id)sender {
    [self back];
}

- (IBAction)sendComment:(id)sender {
    [WGProgressHUD loadMessage:@"正在发表评论" onView:self.view];
    WGWriteBBSRequest *request = [[WGWriteBBSRequest alloc] initWithContent:self.commentTextView.text toUserId:self.toUserId objId:self.objId];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        [WGProgressHUD disappearSuccessMessage:@"发表成功" onView:self.view completBlock:^{
            [self back];
        }];
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.holderLabel.text = @"请输入您的评论";
        self.commentButton.enabled=NO;
    }else{
        
        self.holderLabel.text = @"";
        self.textNumLabel.text = [NSString stringWithFormat:@"可输入%lu字",(unsigned long)(TEXTNUM_MAX-textView.text.length)];
        NSString *feedString=[self.commentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (feedString.length!=0) {
            self.commentButton.enabled=YES;
        }else{
            self.commentButton.enabled=NO;
        }
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    }
    else {
        if (textView.text.length - range.length + text.length > TEXTNUM_MAX) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"超出最大可输入长度" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        else {
            return YES;
        }
    }
}

@end
