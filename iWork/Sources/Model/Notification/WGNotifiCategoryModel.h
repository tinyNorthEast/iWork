//
//  WGNotifiCategoryModel.h
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGNotifiCategoryModel <NSObject>
@end

@interface WGNotifiCategoryModel : WGBaseModel

@property (nonatomic, strong) NSNumber *n_type;
@property (nonatomic, strong) NSNumber *typeCount;

@end
