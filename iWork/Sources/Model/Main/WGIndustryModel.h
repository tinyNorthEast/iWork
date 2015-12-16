//
//  WGIndustryModel.h
//  iWork
//
//  Created by Adele on 12/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGIndustryModel <NSObject>
@end

@interface WGIndustryModel : WGBaseModel

@property (nonatomic,copy)NSString<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *industryName;
@property (nonatomic,strong)NSNumber<Optional> *createTime;

@end
