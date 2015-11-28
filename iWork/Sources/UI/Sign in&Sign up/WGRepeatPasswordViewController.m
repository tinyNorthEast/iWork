//
//  WGRepeatPasswordViewController.m
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGRepeatPasswordViewController.h"

#import "WGSignUpRequest.h"

@interface WGRepeatPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation WGRepeatPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBACtion
- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)backAction:(id)sender {
    [self back];
}
- (IBAction)doneAction:(id)sender {
    WGSignUpRequest *request = [[WGSignUpRequest alloc] initWithInfo:nil];
    [request requestWithSuccess:^(WGBaseModel *model, NSURLSessionTask *task) {
        
    } failure:^(NSError *error, NSURLSessionTask *task) {
        
    }];
    
    
//    [self back];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
