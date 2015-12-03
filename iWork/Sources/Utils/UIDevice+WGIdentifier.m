//
//  UIDevice+WGIdentifier.m
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "UIDevice+WGIdentifier.h"

#import "WGValidJudge.h"
#import "WGDataAccess.h"
#import "NSString+WGMD5.h"
#import "OpenUDID.h"

#define kKeyChainUDID   @"keyChainUDID"

@implementation UIDevice (WGIdentifier)

static NSString * globalDeviceIdentifier = nil;

- (NSString *)UniqueGlobalDeviceIdentifier{
    if ([WGValidJudge isValidString:globalDeviceIdentifier]) {
        return globalDeviceIdentifier;
    }
    
    globalDeviceIdentifier = [WGDataAccess userDefaultsStringForKey:kKeyChainUDID];
       
    if (globalDeviceIdentifier == nil)
    {
        globalDeviceIdentifier = [NSString stringDecodingByMD5:[self idfvString]];
    }
    
    //  如果获取失败，则采用openudid
    if (globalDeviceIdentifier == nil) {
        globalDeviceIdentifier = [OpenUDID value];
    }
    
    //  生成成功后，保存
    if ([WGValidJudge isValidString:globalDeviceIdentifier]) {
        
        [WGDataAccess userDefaultsSetString:globalDeviceIdentifier forKey:kKeyChainUDID];
    }
    
    return globalDeviceIdentifier;
}

- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return nil;
}

@end
