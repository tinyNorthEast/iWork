//
//  WGSignInModel.h
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@interface WGSignInModel : WGBaseModel

@property (nonatomic, copy) NSString<Optional> *token;
@property (nonatomic, copy) NSString<Optional> *zh_name;
@property (nonatomic, strong) NSNumber<Optional> *role_code;
@property (nonatomic, copy) NSString<Optional> *userId;

@end
