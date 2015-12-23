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

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *name;
@property (nonatomic,copy)NSString<Optional> *tip;

@end
