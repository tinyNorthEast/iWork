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

#import "WGSignInModel.h"
#import "WGIndustryModel.h"

#define kIndustryList @"industrylist"

@interface WGGlobal()

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

- (void)saveUserRole:(NSNumber *)role{
    [WGDataAccess saveUserRole:role forKey:kUSERROLR_KEY];
    _userRole = role;
    
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

- (void)clearUserInfo
{
    [WGDataAccess userDefaultsSetString:nil forKey:kUSERTOKEN_KEY];
    _userToken = nil;
    
    [WGDataAccess saveUserRole:nil forKey:kUSERROLR_KEY];
    _userRole = nil;
    
    [WGDataAccess userDefaultsSetString:nil forKey:kDEVICETOKEN_KEY];
    _deviceToken = nil;
}













- (NSArray *)industryLists{
    if (_industryLists == nil)
    {
        _industryLists = [WGDataAccess industryListForKey:kIndustryList];
    }
    return _industryLists;
}

- (void)saveIndustryList:(NSArray *)lists{
    [WGDataAccess industryListSetLists:lists forKey:kIndustryList];
    _industryLists = lists;
    
}
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
- (void )getIndustryList:(void (^)(NSMutableArray *array))block{
    
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
                [self getIndustryList:^(NSMutableArray *array) {
                    
                    if (array.count >= 10)
                    {
                        @weakify(self);
                        [self saveUserEsp:aModel finished:^(DBAccessResult *result) {
                            @strongify(self);
                            [self deleteUserEsp:array.lastObject];
                        }];
                    }
                    else
                    {
                        [self saveUserEsp:aModel finished:^(DBAccessResult *result) {
                            
                        }];
                    }
                }];
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
