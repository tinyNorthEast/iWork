//
//  WGBaseModel.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

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

@end
