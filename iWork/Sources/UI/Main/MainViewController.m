//
//  ViewController.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)signAciton:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
