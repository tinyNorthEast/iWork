//
//  WGTools.m
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGTools.h"

@implementation WGTools

+ (BOOL)checkIsPhoneNumber:(NSString *)input
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:input]   ||
    [regextestphs evaluateWithObject:input]      ||
    [regextestct evaluateWithObject:input]       ||
    [regextestcu evaluateWithObject:input]       ||
    [regextestcm evaluateWithObject:input];
}

+ (void)callPhone:(NSString *)phoneNumber prompt:(BOOL)prompt{
    if ([self checkIsPhoneNumber:phoneNumber]) {
        NSString *call = [NSString stringWithFormat:@"tel://%@", phoneNumber];
        if (prompt) {
            call = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
        }
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:call]];
        } else {
//            NSString *tip = [NSString stringWithFormat:@"您的设备不支持电话，请用其他电话拨打:%@", phoneNumber];
           
        }

    }
}

@end
