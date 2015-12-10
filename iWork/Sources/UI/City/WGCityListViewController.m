//
//  WGCityListViewController.m
//  iWork
//
//  Created by Adele on 12/4/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCityListViewController.h"

#import "WGCityModel.h"

#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
NSString *const CONFIGMODEL_PATH = @"configModel";

@interface WGCityListViewController()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) WGCityModel *cityModel;

@end

@implementation WGCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCitys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WGCityModel *)cityModel
{
    if (!_cityModel)
    {
        NSString *path = [kCacheDirectory stringByAppendingPathComponent:CONFIGMODEL_PATH];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        if (text == nil)
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"native_cityModel" ofType:nil];
            text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
            
            [text writeToFile:[kCacheDirectory stringByAppendingPathComponent:CONFIGMODEL_PATH]
                   atomically:YES
                     encoding:NSUTF8StringEncoding
                        error:nil];
        }
        @try
        {
            _cityModel = [[WGCityModel alloc] initWithString:text error:nil];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
        
    }
    return _cityModel;
}

- (void)loadCitys{
    
}


#pragma mark - IBAction

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
