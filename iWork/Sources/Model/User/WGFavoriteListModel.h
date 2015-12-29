//
//  WGFavoriteListModel.h
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGFavoriteModel.h"

@interface WGFavoriteListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGFavoriteModel> *data;

@end
