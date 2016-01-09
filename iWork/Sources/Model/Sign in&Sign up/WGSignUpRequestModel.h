//
//  WGSignUpRequestModel.h
//  iWork
//
//  Created by Adele on 1/7/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGSignUpModel.h"

@interface WGSignUpRequestModel : WGBaseModel

@property (nonatomic, strong) WGSignUpModel<Optional> *data;

@end
