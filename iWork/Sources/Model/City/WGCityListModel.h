//
//  WGCityListModel.h
//  iWork
//
//  Created by Adele on 12/15/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGCityModel.h"

@interface WGCityListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGCityModel> *air_list;

@end
