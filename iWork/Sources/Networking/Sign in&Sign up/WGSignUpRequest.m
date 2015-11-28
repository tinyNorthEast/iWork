//
//  WGSignUpRequest.m
//  iWork
//
//  Created by Adele on 11/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGSignUpRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGBaseModel.h"

@implementation WGSignUpRequest

///****必填字段****/
//String phone;//手机号
//String password;//密码
//String mail;//邮箱
//String position;//职位
//Integer experience;//工作年限1代表 3年以下 2代表 3-5年 3代表 5-10年 4代表 10年以上
//Integer role_code;// 100-猎头顾问 101-企业HR 102-候选人
//Integer client;//1 android 2 IOS
//String eq_num;//设备号
//String pic;//头像 七牛显示地址
//
///****非必填*****/
//String invate_code;//邀请码

- (instancetype)initWithInfo:(NSDictionary *)infoDict{
    self = [super init];
    if (self) {
        [self.postParams safeSetValue:@"张三" forKey:@"zh_name"];
        [self.postParams safeSetValue:@"18000000778" forKey:@"phone"];
        [self.postParams safeSetValue:@"123456" forKey:@"password"];
        [self.postParams safeSetValue:@"jack_gxy@126.com" forKey:@"mail"];
        [self.postParams safeSetValue:@"IT" forKey:@"position"];
        [self.postParams safeSetValue:@"1" forKey:@"experience"];
        [self.postParams safeSetValue:@"102" forKey:@"role_code"];
        
        [self.postParams safeSetValue:@"2" forKey:@"client"];
        [self.postParams safeSetValue:@"123456" forKey:@"eq_num"];
    
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
    return [[WGBaseModel alloc] initWithDictionary:data error:nil];
}

@end
