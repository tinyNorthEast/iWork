//
//  WGUserInfoRequestModel.h
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@class WGUserInfoModel;

@interface WGUserInfoRequestModel : WGBaseModel

@property (nonatomic, strong) WGUserInfoModel<Optional> *data;

@end
