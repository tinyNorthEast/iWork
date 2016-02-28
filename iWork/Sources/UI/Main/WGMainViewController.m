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

#import "WGProgressHUD.h"

#import "SignHeader.h"
#import "WGMenuBar.h"
#import "WGMainScrollView.h"

#import "WGGlobal.h"
#import "WGCityModel.h"
#import "WGCityListViewController.h"
#import "WGIndustryListRequest.h"
#import "WGMainIndustryListModel.h"
#import "WGNotificationController.h"
#import "WGIndustryDataController.h"

@interface WGMainViewController ()<WGMenuBarDelegate,WGMainScrollViewDelegate>

@property (nonatomic, strong) NSNumber *selectedCityCode;
@property (nonatomic, assign) NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet WGMenuBar *menuBar;
@property (weak, nonatomic) IBOutlet WGMainScrollView *mainScrollView;

@end

@implementation WGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBarView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoNotification:) name:@"GotoNotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initBarView{
    WGIndustryListRequest *request = [[WGIndustryListRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        
        WGMainIndustryListModel *model = (WGMainIndustryListModel *)baseModel;
        [self.menuBar initMenuItems:model.data];
        
        [[WGIndustryDataController sharedInstance] insertIndustry:model.data];
        [[WGGlobal sharedInstance] setIndustryLists:model.data];
        
        self.menuBar.delegate = self;
        
        [self.mainScrollView initWithViews:model.data];
        self.mainScrollView.mainScrolldelegate = self;
        
        [self.menuBar clickButtonAtIndex:0];
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        NSArray *array = [[WGIndustryDataController sharedInstance] fetchIndustry];
        if (array.count) {
            [self.menuBar initMenuItems:array];
            self.menuBar.delegate = self;
            [self.mainScrollView initWithViews:array];
            self.mainScrollView.mainScrolldelegate = self;
            [self.menuBar clickButtonAtIndex:0];
        }else{
            [WGProgressHUD disappearFailureMessage:@"无法连接服务器,请检查网络" onView:self.view];
        }
    }];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        
        self.selectedCityCode = city.areaCode;
        [self.mainScrollView freshContentTableAtIndex:self.currentIndex atCity:self.selectedCityCode];
    };
}

- (IBAction)signAciton:(id)sender {
    UIStoryboard *sb = nil;
    if ([[WGGlobal sharedInstance].userToken length]) {
        sb = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    }else{
        sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
    }
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
- (void)gotoNotification:(NSNotification *)notification{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    WGNotificationController *vc = [sb instantiateViewControllerWithIdentifier:@"Notification"];
    vc.notif_type = notification.object[@"n_type"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - WGMenuBarDelegate
- (void)clickMenuButtonAtIndex:(NSInteger)index{
    self.currentIndex = index;
    [self.mainScrollView moveScrollowViewAthIndex:index];
//    [self.mainScrollView freshContentTableAtIndex:index atCity:self.selectedCityCode];
}
#pragma mark - WGMainScrollViewDelegate
- (void)didScrollPageViewChangedPage:(NSInteger)aPage{
    self.currentIndex = aPage;
    [self.menuBar changeButtonStateAtIndex:aPage];
    //刷新当页数据
    [self.mainScrollView freshContentTableAtIndex:aPage atCity:self.selectedCityCode];
    
}

@end
