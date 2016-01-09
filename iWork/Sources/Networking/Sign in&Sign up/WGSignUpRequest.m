//
//  WGSignUpRequest.m
//  iWork
//
//  Created by Adele on 11/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "UIDevice+WGIdentifier.h"

#import "WGSignUpRequestModel.h"

@implementation WGSignUpRequest

///****必填字段****/
//String phone;//手机号
//String password;//密码
//String zh_name;//中文名称
//String mail;//邮箱
//String position;//职位
//String en_name;//英文名称
//Integer experience;//工作年限1代表 3年以下 2代表 3-5年 3代表 5-10年 4代表 10年以上
//Integer role_code;// 100-猎头顾问 101-企业HR 102-候选人
//Integer client;//1 android 2 IOS
//String eq_num;//设备号
//
///****非必填*****/
//String invate_code;//邀请码
//String pic;//头像 七牛显示地址

- (instancetype)initWithInfo:(NSDictionary *)infoDict{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:infoDict[@"zh_name"] forKey:@"zh_name"];
        [self.postParams safeSetValue:infoDict[@"en_name"] forKey:@"en_name"];
        [self.postParams safeSetValue:infoDict[@"phone"] forKey:@"phone"];
        [self.postParams safeSetValue:infoDict[@"password"] forKey:@"password"];
        [self.postParams safeSetValue:infoDict[@"mail"] forKey:@"mail"];
        [self.postParams safeSetValue:infoDict[@"position"] forKey:@"position"];
        [self.postParams safeSetValue:infoDict[@"experience"] forKey:@"experience"];
        [self.postParams safeSetValue:infoDict[@"role_code"] forKey:@"role_code"];
        [self.postParams safeSetValue:infoDict[@"invate_code"] forKey:@"invate_code"];
        [self.postParams safeSetValue:infoDict[@"pic"] forKey:@"pic"];

        return self;
    }
    return nil;
}

- (NSString *)pathName{
    return @"api/v1/user/regist.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodPOST;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGSignUpRequestModel alloc] initWithDictionary:data error:nil];
}

@end
