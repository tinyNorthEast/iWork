//
//  WGSignInModel.h
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

typedef enum{
    UserRole_Hunter = 100,
    UserRole_HR = 101,
    UserRole_Candidate= 102,

}UserRole;



@interface WGSignInModel : WGBaseModel

@property (nonatomic, copy) NSString<Optional> *token;
@property (nonatomic, copy) NSString<Optional> *mail;
@property (nonatomic, copy) NSString<Optional> *zh_name;
@property (nonatomic, strong) NSNumber<Optional> *role_code;
@property (nonatomic, strong) NSNumber<Optional> *userId;

@end
