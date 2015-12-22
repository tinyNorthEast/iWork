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

#import "WGHunterDetailRequest.h"
#import "WGBaseModel.h"
#import "WGHunterDetailModel.h"
#import "WGHunterInfoModel.h"
#import "WGDetailHeaderView.h"
#import "WGIntroductionView.h"
#import "WGIndustryView.h"
#import "WGIndustryModel.h"

@interface WGHunterDetailViewController ()
@property (weak, nonatomic) IBOutlet WGDetailHeaderView *headerView;
@property (weak, nonatomic) IBOutlet WGIntroductionView *describeView;
@property (weak, nonatomic) IBOutlet WGIndustryView *industryView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *industryHeight;

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
- (IBAction)writeBBS:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"WriteBBS" bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
- (IBAction)callConsultant:(id)sender {
    [WGTools callPhone:@"" prompt:NO];
}


#pragma mark - Request
- (void)requestDetailData{
    WGHunterDetailRequest *request = [[WGHunterDetailRequest alloc] initWithHunterId:@(16)];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == 0) {
            WGHunterDetailModel *model = (WGHunterDetailModel *)baseModel;
            WGHunterInfoModel *infoModel = [[WGHunterInfoModel alloc] initWithDictionary:model.data[@"headhunterInfo"] error:nil];
            
            self.headerView.infoModel = infoModel;
            self.headerHeight.constant = 255;
            
            self.describeView.describeStr = infoModel.describe;
            self.describeHeight.constant = 130;
            
            NSMutableArray *industrys = [NSMutableArray array];
            for (WGIndustryModel *industryModel in infoModel.industryList) {
                [industrys addObject:industryModel.industryName];
            }
            self.industryView.tagsArray = industrys;
            self.industryHeight.constant = 100;
            
        }else{
            [WGProgressHUD disappearFailureMessage:baseModel.message onView:self.view];
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
}

@end
