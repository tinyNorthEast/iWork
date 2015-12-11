//
//  WGCityListViewController.m
//  iWork
//
//  Created by Adele on 12/4/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGCityListViewController.h"

#import "WGCityModel.h"
#import "WGCityListRequest.h"

#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
NSString *const CONFIGMODEL_PATH = @"configModel";

@interface WGCityListViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *cityGroups;
@property (nonatomic, strong) NSArray *cityList;
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
            _cityModel = [[WGCityModel alloc] initWithString:text error:nil];
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

    WGCityModel *aCity1 = [[WGCityModel alloc] init];
    aCity1.city_name = @"北京";
    WGCityModel *aCity2 = [[WGCityModel alloc] init];
    aCity2.city_name = @"上海";
    WGCityModel *aCity3 = [[WGCityModel alloc] init];
    aCity3.city_name = @"广东";
    WGCityModel *aCity4 = [[WGCityModel alloc] init];
    aCity4.city_name = @"深圳";
    WGCityModel *aCity5 = [[WGCityModel alloc] init];
    aCity5.city_name = @"成都";
    WGCityModel *aCity6 = [[WGCityModel alloc] init];
    aCity6.city_name = @"苏州";
    self.cityList = @[aCity1,aCity2,aCity3,aCity4,aCity5,aCity6];
    
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
    }

    WGCityModel *cityModel = [self.cityList objectAtIndex:indexPath.row];
    cell.textLabel.text = cityModel.city_name;

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
