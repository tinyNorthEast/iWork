//
//  WGGlobal.h
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBAccessQueue.h"
#import "SynthesizeSingletonForArc.h"

@class WGIndustryModel;

@interface WGGlobal : NSObject

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(WGGlobal)

@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, strong) NSNumber *userRole;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *defaultPhone;


@property (nonatomic, copy) NSArray *industryLists;

- (void)saveToken:(NSString *)token;

- (void)saveUserRole:(NSNumber *)role;

- (void)saveDeviceToken:(NSString *)deviceToken;

- (void)saveDefaultPhone:(NSString *)defualtPhone;

- (void)clearUserInfo;














- (void )getIndustryList:(void (^)(NSMutableArray *array))block;

-(void)insertOrUpdateFlightModel:(WGIndustryModel *)aModel
                         success:(void (^)(WGIndustryModel *model))success
                         failure:(void (^)(DBAccessResultType result))failure;

- (void)saveIndustryList:(NSArray *)lists;
- (void)clearIndustryList;

@end
