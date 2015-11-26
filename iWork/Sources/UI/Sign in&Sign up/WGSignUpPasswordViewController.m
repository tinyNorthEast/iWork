//
//  WGSignUpPasswordViewController.m
//  iWork
//
//  Created by Adele on 11/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpPasswordViewController.h"

@interface WGSignUpPasswordViewController ()

@end

@implementation WGSignUpPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBACtion
- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
