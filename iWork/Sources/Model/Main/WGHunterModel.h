//
//  WGHunterModel.h
//  iWork
//
//  Created by Adele on 12/15/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGHunterIndustryModel.h"

@protocol WGHunterModel <NSObject>
@end

@interface WGHunterModel : WGBaseModel

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *realName;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,copy)NSString<Optional> *smallPic;
@property (nonatomic,copy)NSString<Optional> *signature;
@property (nonatomic,strong)NSNumber<Optional> *ranking;
@property (nonatomic,strong)NSNumber<Optional> *commentCount;
@property (nonatomic,strong)NSNumber<Optional> *attentionCount;
@property (nonatomic,strong)NSArray <Optional,WGHunterIndustryModel> *industryList;
@property (nonatomic,strong)NSNumber <Optional>*userId;
@property (nonatomic,strong)NSNumber <Optional>*isAttention;

@end
