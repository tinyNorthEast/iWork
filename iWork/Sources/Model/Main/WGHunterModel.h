//
//  WGHunterModel.h
//  iWork
//
//  Created by Adele on 12/15/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGIndustryModel.h"

@protocol WGHunterModel <NSObject>
@end

@interface WGHunterModel : WGBaseModel

@property (nonatomic,copy)NSString<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *realName;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,strong)NSNumber<Optional> *ranking;
@property (nonatomic,strong)NSNumber<Optional> *commentCount;
@property (nonatomic,strong)NSArray <Optional,WGIndustryModel> *industryList;

@end
