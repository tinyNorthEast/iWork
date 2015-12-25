//
//  WGBBSListModel.h
//  iWork
//
//  Created by Adele on 12/25/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGCommentModel.h"

@interface WGBBSListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGCommentModel> *data;

@end
