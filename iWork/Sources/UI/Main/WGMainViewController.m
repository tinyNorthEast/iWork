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

#import "WGDataAccess.h"

#import "SignHeader.h"
#import "WGMenuBar.h"
#import "WGMainScrollView.h"

#import "WGCityModel.h"
#import "WGCityListViewController.h"

@interface WGMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cityButton;

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
    WGCityListViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
    @weakify(self);
    vc.selectCity = ^(WGCityModel *city){
        @strongify(self);
        [self.cityButton setTitle:city.areaName forState:UIControlStateNormal];
    };
}

- (IBAction)signAciton:(id)sender {
    UIStoryboard *sb = nil;
    if ([WGDataAccess userDefaultsStringForKey:kUSERTOKEN_KEY].length) {
        sb = [UIStoryboard storyboardWithName:@"User" bundle:nil];
        
    }else{
        sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    }
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

@end
