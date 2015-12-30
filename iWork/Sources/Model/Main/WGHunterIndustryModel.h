//
//  WGHunterIndustryModel.h
//  iWork
//
//  Created by Adele on 12/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGHunterIndustryModel <NSObject>

@end

@interface WGHunterIndustryModel : WGBaseModel

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,strong)NSNumber<Optional> *createTime;
@property (nonatomic,copy)NSString<Optional> *industryName;

@end
