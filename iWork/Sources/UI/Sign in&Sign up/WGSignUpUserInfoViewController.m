//
//  WGSignUpUserInfoViewController.m
//  iWork
//
//  Created by Adele on 11/26/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpUserInfoViewController.h"

@interface WGSignUpUserInfoViewController ()<UIActionSheetDelegate>

@end

@implementation WGSignUpUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBACtion
- (IBAction)addPhotoAction:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择",nil];
    [as showInView:self.view];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
