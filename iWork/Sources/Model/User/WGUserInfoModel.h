//
//  WGUserInfoModel.h
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@interface WGUserInfoModel : WGBaseModel

@property (nonatomic, copy) NSString<Optional> *zh_name;
@property (nonatomic, copy) NSString<Optional> *password;
@property (nonatomic, copy) NSString<Optional> *mail;
@property (nonatomic, copy) NSString<Optional> *en_name;
@property (nonatomic, copy) NSString<Optional> *company;
@property (nonatomic, strong) NSNumber<Optional> *experience;
@property (nonatomic, copy) NSString<Optional> *roleName;
@property (nonatomic, copy) NSString<Optional> *pic;

@end
