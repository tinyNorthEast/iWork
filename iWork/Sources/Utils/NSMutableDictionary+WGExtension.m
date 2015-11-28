//
//  NSMutableDictionary+WGExtension.m
//  iWork
//
//  Created by Adele on 11/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "NSMutableDictionary+WGExtension.h"

@implementation NSMutableDictionary (WGExtension)

- (void)safeSetValue:(id)aValue forKey:(NSString *)aKey{
    if (aValue != nil) {
        [self setValue:aValue forKey:aKey];
    }else{
        [self removeObjectForKey:aKey];
    }
}

@end
