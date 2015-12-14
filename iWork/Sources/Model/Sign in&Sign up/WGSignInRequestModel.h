//
//  WGSignInRequestModel.h
//  iWork
//
//  Created by Adele on 12/14/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@class WGSignInModel;

@interface WGSignInRequestModel : WGBaseModel

@property (nonatomic, strong) WGSignInModel<Optional> *data;

@end
