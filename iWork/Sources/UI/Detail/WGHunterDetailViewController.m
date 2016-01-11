//
//  WGHunterDetailViewController.m
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGHunterDetailViewController.h"

#import <extobjc.h>
#import <ShareSDK/ShareSDK.h>

#import "WGProgressHUD.h"
#import "UIViewAdditions.h"
#import "WGTools.h"

#import "WGGlobal.h"
#import "WGWriteBBSViewController.h"
#import "WGHunterDetailRequest.h"
#import "WGHunterDetailModel.h"
#import "WGHunterInfoModel.h"
#import "WGDetailHeaderView.h"
#import "WGIntroductionView.h"
#import "WGIndustryView.h"
#import "WGFunctionView.h"
#import "WGResultsView.h"
#import "WGBBSView.h"

@interface WGHunterDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet WGDetailHeaderView *headerView;
@property (weak, nonatomic) IBOutlet WGIntroductionView *describeView;
@property (weak, nonatomic) IBOutlet WGIndustryView *industryView;
@property (weak, nonatomic) IBOutlet WGFunctionView *functionView;
@property (weak, nonatomic) IBOutlet WGResultsView *resultsView;
@property (weak, nonatomic) IBOutlet WGBBSView *bbsView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *industryHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *functionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bbsHeight;

@end

@implementation WGHunterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerHeight.constant = 255;
    self.describeHeight.constant = 70;
    self.industryHeight.constant = 50;
    self.functionHeight.constant = 100;
    self.resultsHeight.constant = 110;
    self.bbsHeight.constant = 110;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestDetailData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)shareAction:(id)sender {
    if (![self isSignIn]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }else{
        

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:self];
    
    NSArray *shareList = [ShareSDK getShareListWithType:
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,
                          ShareTypeSinaWeibo,
                          nil];
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }
                            }];
    }
}
- (BOOL)isSignIn{
    return ([[WGGlobal sharedInstance] userToken].length>0?YES:NO);
}
- (IBAction)writeBBS:(id)sender {
    if ([self isSignIn]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"WriteBBS" bundle:nil];
        WGWriteBBSViewController *vc = [sb instantiateInitialViewController];
        vc.toUserId = self.headerView.infoModel.userId;
        vc.objId = self.headerView.infoModel.objId;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

- (IBAction)callConsultant:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:self.headerView.infoModel.phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alert show];
    
}

#pragma mark - Request
- (void)requestDetailData{
    [WGProgressHUD defaultLoadingOnView:self.view];
    
    WGHunterDetailRequest *request = [[WGHunterDetailRequest alloc] initWithHunterId:self.hunterId];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        [WGProgressHUD dismissOnView:self.view];
        if (baseModel.infoCode.integerValue == TokenFailed) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
            UIViewController *vc = [sb instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
        else if (baseModel.infoCode.integerValue == 0) {
            WGHunterDetailModel *model = (WGHunterDetailModel *)baseModel;
            
            WGHunterInfoModel *infoModel = [[WGHunterInfoModel alloc] initWithDictionary:model.data[@"headhunterInfo"] error:nil];
            
            self.headerView.infoModel = infoModel;
            
            self.describeHeight.constant = [self.describeView viewHeightbyDescribeArray:infoModel.describeList];
            
            self.industryHeight.constant = [self.industryView viewHeightbyTagsArray:infoModel.industryList];
            
            self.functionHeight.constant = [self.functionView viewHeightbyFunctionsArray:infoModel.functionsList];
            
            NSArray *resultsArray = model.data[@"performanceList"];
            self.resultsView.objId = self.hunterId;
            self.resultsHeight.constant = [self.resultsView viewHeightbyResultsArray:resultsArray];
            
            NSArray *bbsArray = model.data[@"commentList"];
            self.bbsView.objId = self.hunterId;
            self.bbsHeight.constant = [self.bbsView viewHeightbyCommentsArray:bbsArray];
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [WGTools callPhone:self.headerView.infoModel.phone prompt:NO];
    }
}

@end
