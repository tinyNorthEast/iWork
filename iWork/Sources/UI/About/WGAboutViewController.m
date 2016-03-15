//
//  WGAboutViewController.m
//  iWork
//
//  Created by Adele on 12/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGAboutViewController.h"

#import "WGTools.h"

@interface WGAboutViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@end

@implementation WGAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    self.versionLabel.text=[NSString stringWithFormat:@"V%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [self.logoImageView setImage:[UIImage imageNamed:@"aboutLogo"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)callAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"13439321812" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alert show];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [WGTools callPhone:@"13439321812" prompt:NO];
    }
}
@end
