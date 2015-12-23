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
#import "WGIndustryListRequest.h"
#import "WGMainIndustryListModel.h"

@interface WGMainViewController ()<WGMenuBarDelegate,WGMainScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet WGMenuBar *menuBar;
@property (weak, nonatomic) IBOutlet WGMainScrollView *mainScrollView;

@end

@implementation WGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBarView];
}

- (void)initBarView{
    WGIndustryListRequest *request = [[WGIndustryListRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        WGMainIndustryListModel *model = (WGMainIndustryListModel *)baseModel;
//        NSArray *barItems = @[@"法务",@"财务",@"HR",@"消费品",@"互联网&通讯",@"汽车&机械",@"金融服务",@"供应链",@"化工",@"医疗&生命科学",@"地产"];
        [self.menuBar initMenuItems:model.data];
        self.menuBar.delegate = self;
        
        [self.mainScrollView initWithViews:model.data];
        self.mainScrollView.mainScrolldelegate = self;
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
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

#pragma mark - WGMenuBarDelegate
- (void)clickMenuButtonAtIndex:(NSInteger)index{
    [self.mainScrollView moveScrollowViewAthIndex:index];
}
#pragma mark - WGMainScrollViewDelegate
- (void)didScrollPageViewChangedPage:(NSInteger)aPage{
    [self.menuBar changeButtonStateAtIndex:aPage];
    //刷新当页数据
    //    [mScrollPageView freshContentTableAtIndex:aPage];
    
}


@end
