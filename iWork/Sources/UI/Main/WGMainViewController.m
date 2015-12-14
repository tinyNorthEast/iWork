//
//  ViewController.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainViewController.h"

#import <extobjc.h>
#import <XXNibBridge.h>

#import "WGMenuBar.h"
#import "WGMainScrollView.h"
#import "SignHeader.h"
#import "WGDataAccess.h"

@interface WGMainViewController ()

@end

@implementation WGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)chooseCityAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"City" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)signAciton:(id)sender {
    if ([WGDataAccess userDefaultsStringForKey:kUSERTOKEN_KEY].length) {
        
    }
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WGSignUpWorkInfoViewController"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
