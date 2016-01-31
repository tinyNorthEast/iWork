//
//  WGCityListViewController.m
//  iWork
//
//  Created by Adele on 12/4/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCityListViewController.h"

#import <extobjc.h>

#import "WGProgressHUD.h"
#import "UIViewAdditions.h"
#import "UIColor+WGThemeColors.h"

#import "WGCityModel.h"
#import "WGCityListModel.h"
#import "WGCityListRequest.h"
#import "WGCityDataController.h"

#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
NSString *const CONFIGMODEL_PATH = @"configModel";

@interface WGCityListViewController()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *cityTable;
@property (nonatomic, strong) NSMutableArray *cityList;

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

#pragma mark - Init
- (NSMutableArray *)cityList{
    if (!_cityList) {
        _cityList = [NSMutableArray arrayWithCapacity:0];
    }
    return _cityList;
}
- (NSArray *)cacheCityList
{
    if (!self.cityList)
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
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
        
    }
    return self.cityList;
}

- (void)loadCitys{
    WGCityListRequest *request = [[WGCityListRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == TokenFailed) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
        else if (baseModel.infoCode.integerValue == 0) {
            WGCityListModel *model = (WGCityListModel *)baseModel;
            if (model.data.count) {
    
                [[WGCityDataController sharedInstance] insertCity:model.data];
                
                [self.cityList addObjectsFromArray:model.data];
                [self.cityTable reloadData];
            }
        }else{
            
            NSArray *array =  [[WGCityDataController sharedInstance] fetchCitys];
            if (array.count) {
                [self.cityList addObjectsFromArray:array];
                [self.cityTable reloadData];
            }else{
                [WGProgressHUD disappearFailureMessage:@"无法连接服务器,请检查网络" onView:self.view];
            }
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        [WGProgressHUD disappearFailureMessage:@"加载失败" onView:self.view];
    }];
}

#pragma mark - IBAction
- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)backAction:(id)sender {
    [self back];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.height-1, tableView.width-10, 1)];
        lineView.backgroundColor = [UIColor wg_themeDarkWhiteColor];
        [cell.contentView addSubview:lineView];
    }

    WGCityModel *cityModel = [self.cityList objectAtIndex:indexPath.row];
    cell.textLabel.text = cityModel.areaName;

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WGCityModel *aCityModel = [self.cityList objectAtIndex:indexPath.row];
    if (aCityModel!=nil && _selectCity)
    {
        _selectCity(aCityModel);
    }
    [self back];
}

@end
