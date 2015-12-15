//
//  WGCityModel.h
//  iWork
//
//  Created by Adele on 12/4/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGCityModel <NSObject>
@end

@interface WGCityModel : WGBaseModel

@property (nonatomic,copy)NSString<Optional> *areaId;
@property (nonatomic,copy)NSString<Optional> *areaName;
@property (nonatomic,copy)NSString<Optional> *areaCode;
@property (nonatomic,copy)NSString<Optional> *areaIsLeaf;
@property (nonatomic,copy)NSString<Optional> *areaLevel;
@property (nonatomic,copy)NSString<Optional> *areaSort;
@property (nonatomic,copy)NSNumber<Optional> *createTime;

@end
