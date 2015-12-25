//
//  WGWriteBBSViewController.m
//  iWork
//
//  Created by Adele on 12/21/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGWriteBBSViewController.h"

#import <extobjc.h>

#import "WGWriteBBSRequest.h"

@interface WGWriteBBSViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *holderLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation WGWriteBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    WGWriteBBSRequest *request = [[WGWriteBBSRequest alloc] initWithContent:self.commentTextView.text toUserId:self.toUserId];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        [self back];
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
        NSString *feedString=[self.commentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (feedString.length!=0) {
            self.commentButton.enabled=YES;
        }else{
            self.commentButton.enabled=NO;
        }
        
    }
}

@end
