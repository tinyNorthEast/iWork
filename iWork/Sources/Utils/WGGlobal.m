//
//  WGGlobal.m
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGGlobal.h"

#import <extobjc.h>

#import "WGDataAccess.h"
#import "DEFileUtil.h"
#import "DEReflectUtil.h"
#import "SignHeader.h"
#import "UIViewAdditions.h"

#import "WGSignInModel.h"
#import "WGIndustryModel.h"
#import "WGSignInModel.h"
#import "WGCityListRequest.h"
#import "WGIndustryListRequest.h"
#import "WGMainIndustryListModel.h"

#define kIndustryList @"industrylist"

@interface WGGlobal()

@property (nonatomic, strong) UIImageView *defualtView;

@property(nonatomic,strong)dispatch_queue_t userEspQueue;
@property(nonatomic,strong)DBAccessQueue *dbUserHandler;
@property(nonatomic,strong)dispatch_queue_t fileQueue;
@property(nonatomic,strong)DEReflectUtil *refrect;
@property(nonatomic,strong)DBAccessQueue *dbLogHandler;
@property(nonatomic,strong)NSFileHandle *fileHandle;
@property(nonatomic,strong)NSDateFormatter *logDF;

@end

@implementation WGGlobal

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(WGGlobal)

-(UIImageView *)defualtView{
    if (!_defualtView) {
        _defualtView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_image"]];
    }
    return _defualtView;
}
- (void)addDefaultImageViewTo:(UIView *)view isHidden:(BOOL)hidden{
    [view addSubview:self.defualtView];
    [self.defualtView setCenter:CGPointMake(view.width/2, view.height/2)];
    
    [self.defualtView setHidden:hidden];
}
- (NSString *)userToken
{
    if (_userToken == nil)
    {
        _userToken = [WGDataAccess userDefaultsStringForKey:kUSERTOKEN_KEY];
        
    }
    return _userToken;
}

- (NSString *)deviceToken{
    if (_deviceToken == nil)
    {
        _deviceToken = [WGDataAccess userDefaultsStringForKey:kDEVICETOKEN_KEY];
        
    }
    return _deviceToken;
}

- (NSString *)defaultPhone{
    if (_defaultPhone == nil)
    {
        _defaultPhone = [WGDataAccess userDefaultsStringForKey:kUSERDEFAULTPHONE];
        
    }
    return _defaultPhone;    
}
- (WGSignInModel *)signInfo{
    NSMutableDictionary *afterData = [[NSMutableDictionary alloc] initWithContentsOfFile:[self fileName]];
    WGSignInModel *infoModel = [[WGSignInModel alloc] initWithDictionary:afterData error:nil];
    return infoModel;
}
- (void)saveToken:(NSString *)token
{
    [WGDataAccess userDefaultsSetString:token forKey:kUSERTOKEN_KEY];
    _userToken = token;
}

- (void)saveDeviceToken:(NSString *)deviceToken{
    [WGDataAccess userDefaultsSetString:deviceToken forKey:kDEVICETOKEN_KEY];
    _deviceToken = deviceToken;
}

- (void)saveDefaultPhone:(NSString *)defualtPhone{
    [WGDataAccess userDefaultsSetString:defualtPhone forKey:kUSERDEFAULTPHONE];
    _defaultPhone = defualtPhone;
}
- (NSString *)fileName{
    //获取应用沙盒的的DOCUMENT 的路径；
    //在此处设置文件的名字补全其中的路径, 注意对于文件内存的修改是在内存之中完成的，然后直接把现在的数据一次性更新，这样减少了文件的读写的次数
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* plistPath1 = [paths objectAtIndex:0];
    NSString *filename =[plistPath1 stringByAppendingPathComponent:@"userInfo.plist"];
    return filename;
}
- (void)saveSignInfo:(NSDictionary *)dict{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    infoDict = [dict mutableCopy];
    //写入文件
    [infoDict writeToFile:[self fileName] atomically:YES];
}

- (void)clearUserInfo
{
    [WGDataAccess userDefaultsSetString:nil forKey:kUSERTOKEN_KEY];
    _userToken = nil;
    
    [WGDataAccess userDefaultsSetString:nil forKey:kDEVICETOKEN_KEY];
    _deviceToken = nil;
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:[self fileName] error:nil];
}



//- (NSArray *)industryLists{
//    if (_industryLists == nil)
//    {
//        _industryLists = [WGDataAccess industryListForKey:kIndustryList];
//    }
//    return _industryLists;
//}
//
//- (void)saveIndustryList:(NSArray *)lists{
//    [WGDataAccess industryListSetLists:lists forKey:kIndustryList];
//    _industryLists = lists;
//    
//}
- (void)clearIndustryList{
    [WGDataAccess industryListSetLists:nil forKey:kIndustryList];
    _industryLists = nil;
}

- (dispatch_queue_t)userEspQueue{
    if (!_userEspQueue) {
        _userEspQueue = dispatch_queue_create("com.impetusconsulting.userlog", DISPATCH_QUEUE_SERIAL);
    }
    return _userEspQueue;
}


- (WGCityListModel *)cityListModel{
    if (_cityListModel == nil)
    {
        return [self getCacheCityListRequestModelWithCityID:nil];
    }
    return _cityListModel;
}
- (WGCityListModel *)getCacheCityListRequestModelWithCityID:(NSString*)cityID;
{
    id jsonObject = [DEFileUtil getRequestModelCacheObjectWithRequestClass:[WGCityListModel class] key:cityID];
    WGCityListModel *model = nil;
    
    if (jsonObject) {
        model = [[WGCityListModel alloc] initWithDictionary:jsonObject error:nil];
    }
    return model;
}

- (WGMainIndustryListModel *)industryModel{
    if (_industryModel == nil)
    {
        return [self getCacheIndustryListRequestModelWithCityID:nil];
    }else{
        [self getIndustryList];
    }
    return _industryModel;
}

- (WGMainIndustryListModel *)getCacheIndustryListRequestModelWithCityID:(NSString*)cityID;
{
    id jsonObject = [DEFileUtil getRequestModelCacheObjectWithRequestClass:[WGMainIndustryListModel class] key:cityID];
    WGMainIndustryListModel *model = nil;
    
    if (jsonObject) {
        model = [[WGMainIndustryListModel alloc] initWithDictionary:jsonObject error:nil];
    }
    return model;
}
- (NSArray *)getCityList{
    if (self.cityListModel.data.count){
        return self.cityListModel.data;
    }
    WGCityListRequest *request = [[WGCityListRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        if (baseModel.infoCode.integerValue == 0) {
            WGCityListModel *model = (WGCityListModel *)baseModel;
            if (model.data.count) {
                
                [DEFileUtil cacheRequestModel:model requestClass:[WGCityListModel class] key:nil];
                
                [self.cities addObjectsFromArray:model.data];

            }
        }else{
        }
    } failure:^(WGBaseModel *baseModel, NSError *error) {
    }];
    return self.cities;
}

- (NSArray *)getIndustryList{
    if (self.industryModel.data.count) {
        return self.industryModel.data;
    }
    WGIndustryListRequest *request = [[WGIndustryListRequest alloc] init];
    @weakify(self);
    [request requestWithSuccess:^(WGBaseModel *baseModel, NSError *error) {
        @strongify(self);
        WGMainIndustryListModel *model = (WGMainIndustryListModel *)baseModel;
        if (model.data) {
             [DEFileUtil cacheRequestModel:model requestClass:[WGMainIndustryListModel class] key:nil];
            
            [self.industryLists addObjectsFromArray:model.data];
        }
        
    } failure:^(WGBaseModel *baseModel, NSError *error) {
        
    }];
    return self.industryLists;
}
-(void)insertOrUpdateFlightModel:(WGIndustryModel *)aModel
                         success:(void (^)(WGIndustryModel *model))success
                         failure:(void (^)(DBAccessResultType result))failure{
    
    if (self.userEspQueue) {
        dispatch_async(self.userEspQueue, ^{
            DBRestriction *restriction = [[DBRestriction alloc] initWithName:@"flight_no" value: aModel.objId.stringValue restrictionType:DBRestrictionTypeEQ];
            [restriction andPropertyName:@"from_city" value:aModel.name restrictionType:DBRestrictionTypeEQ];
            
            DBAccessResult *rst = [self.dbUserHandler findEntity:@"IndustryList" withRestriction:restriction];
            if ([(NSArray *)rst.object count])
            {
                WGIndustryModel *model = [((NSArray *)rst.object) firstObject];
                
                if (rst.resultType == DBAccessResultTypeOK)
                {
                    if (model.objId.stringValue.length > 0)
                    {
                        @weakify(self);
                        [self saveUserEsp:aModel finished:^(DBAccessResult *result) {
                            @strongify(self);
                            [self deleteUserEsp:model];
                        }];
                    }
                }
            }
            else
            {
//                [self getIndustryList:^(NSMutableArray *array) {
//                    
//                    if (array.count >= 10)
//                    {
//                        @weakify(self);
//                        [self saveUserEsp:aModel finished:^(DBAccessResult *result) {
//                            @strongify(self);
//                            [self deleteUserEsp:array.lastObject];
//                        }];
//                    }
//                    else
//                    {
//                        [self saveUserEsp:aModel finished:^(DBAccessResult *result) {
//                            
//                        }];
//                    }
//                }];
            }
            
        });
    }
}
-(void)openLogDB{
    DBAccess *dlog = [[DBAccess alloc] initWithPath:[DEFileUtil logDBPath]];
    [dlog open];
    [dlog createTablesWithNames:@[@"DERequestURLDetailLogModel",@"DEPushLogModel",
                                  @"DEGPSStateLogModel",@"DECommonLog"]];
    [dlog close];
    
    self.dbLogHandler = [[DBAccessQueue alloc] initWithPath:[DEFileUtil logDBPath]];
    self.dbLogHandler.disableAutoConnect = YES;
    [self.dbLogHandler openDBQueue];
}
-(void)resetLogDB{
    [self.dbUserHandler closeDBQueue];
    self.dbUserHandler = nil;
    [self openLogDB];
}
-(void)saveUserEsp:(id)model finished:(void (^)(DBAccessResult *))block{
    if (self.userEspQueue) {
        dispatch_async(self.userEspQueue, ^{
            [self.dbUserHandler save:model finished:^(DBAccessResult *result) {
                
                if (result.resultType != DBAccessResultTypeOK) {
                    NSString *str = [self.refrect toStringWithObject:model];
                    [self saveFileLog:str];
                    [self performSelector:@selector(resetLogDB) withObject:nil afterDelay:0.3];
                }
                if (block) {
                    block(result);
                }
            }];
        });
    }
}
-(void)deleteUserEsp:(id)model{
    if (self.userEspQueue) {
        dispatch_async(self.userEspQueue, ^{
            [self.dbUserHandler deletee:model finished:^(DBAccessResult *result) {
                
            }];
        });
    }
}
-(void)saveFileLog:(NSString *)log{
    if (self.fileQueue) {
        dispatch_async(self.fileQueue, ^{
            if (log.length < 2) {
                return ;
            }
            NSString *strr = [NSString stringWithFormat:@"%@##%@\n",[self currentLogTime],log];
            NSData *dtt = [strr dataUsingEncoding:NSUTF8StringEncoding];
            [self.fileHandle seekToEndOfFile];
            [self.fileHandle writeData:dtt];
            [self.fileHandle synchronizeFile];
        });
    }
}
-(NSString *)currentLogTime{
//    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:kDEGlobal.currentTimeMillis];
    NSDate *dt = [NSDate date];
    return [self.logDF stringFromDate:dt];
}

@end
