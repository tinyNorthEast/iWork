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

#import "WGHunterDetailRequest.h"
#import "WGBaseModel.h"
#import "WGHunterDetailModel.h"
#import "WGHunterInfoModel.h"
#import "WGDetailHeaderView.h"
#import "WGIntroductionView.h"

@interface WGHunterDetailViewController ()
@property (weak, nonatomic) IBOutlet WGDetailHeaderView *headerView;
@property (weak, nonatomic) IBOutlet WGIntroductionView *describeView;


@end

@implementation WGHunterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

#pragma mark - Request
- (void)requestDetailData{
    WGHunterDetailRequest *request = [[WGHunterDetailRequest alloc] initWithHunterId:@(3)];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == 0) {
            WGHunterDetailModel *model = (WGHunterDetailModel *)baseModel;
            WGHunterInfoModel *infoModel = [[WGHunterInfoModel alloc] initWithDictionary:model.data[@"headhunterInfo"] error:nil];
            self.headerView.infoModel = infoModel;
            self.describeView.describeStr = infoModel.describe;
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

@end
