//
//  WGGlobal.h
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DBAccessQueue.h"
#import "SynthesizeSingletonForArc.h"

#import "WGCityListModel.h"
#import "WGMainIndustryListModel.h"

@class WGSignInModel;
@class WGIndustryModel;


@interface WGGlobal : NSObject

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(WGGlobal)

@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *defaultPhone;
@property (nonatomic, copy) NSMutableArray *industryLists;
@property (nonatomic, strong) NSMutableArray *cities;

@property (nonatomic, strong) WGCityListModel *cityListModel;
@property (nonatomic, strong) WGMainIndustryListModel *industryModel;

@property (nonatomic, copy) WGSignInModel *signInfo;

- (void)saveToken:(NSString *)token;

- (void)saveDeviceToken:(NSString *)deviceToken;

- (void)saveDefaultPhone:(NSString *)defualtPhone;

- (void)saveSignInfo:(NSDictionary *)dict;

- (void)clearUserInfo;

- (void)addDefaultImageViewTo:(UIView *)view isHidden:(BOOL)hidden;









- (NSArray *)getCityList;

- (NSArray *)getIndustryList;

- (void)insertOrUpdateFlightModel:(WGIndustryModel *)aModel
                         success:(void (^)(WGIndustryModel *model))success
                         failure:(void (^)(DBAccessResultType result))failure;

- (void)saveIndustryList:(NSArray *)lists;
- (void)clearIndustryList;

@end
