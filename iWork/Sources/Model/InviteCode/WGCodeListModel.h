//
//  WGCodeListModel.h
//  iWork
//
//  Created by Adele on 12/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGCodeModel.h"

@interface WGCodeListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGCodeModel> *data;

@end
