//
//  WGIndustryListModel.h
//  iWork
//
//  Created by Adele on 12/23/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#include "WGIndustryModel.h"

@interface WGMainIndustryListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGIndustryModel> *data;

@end
