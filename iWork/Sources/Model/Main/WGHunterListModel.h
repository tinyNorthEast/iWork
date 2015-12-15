//
//  WGHunterListModel.h
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGHunterModel.h"

@interface WGHunterListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGHunterModel> *data;

@end
