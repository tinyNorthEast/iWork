//
//  WGBaseModel.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGValidJudge.h"

@implementation WGBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    if (!self) {
        return nil;
    }
    return self;
}
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithJSONToModelBlock:^NSString *(NSString *keyName) {
        return keyName;
    } modelToJSONBlock:^NSString *(NSString *keyName) {
        return keyName;
    }];
}

- (NSString<Optional> *)message{
    if (_message != nil && [WGValidJudge isValidString:_message]) {
        return _message;
    }
    return @"";
}

- (BOOL)isValid{
    return (_infoCode != nil && self.infoCode.integerValue == 0);
}

@end
