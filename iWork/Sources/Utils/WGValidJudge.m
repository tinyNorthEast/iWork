//
//  WGValidJudge.m
//  iWork
//
//  Created by Adele on 11/16/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGValidJudge.h"

@implementation WGValidJudge

+ (BOOL)isValidCGFloat:(CGFloat)afloat{
    return (afloat>0)?YES:NO;
}

+ (BOOL)isValidInteger:(NSInteger)integer{
    return (integer>0)?YES:NO;
}

+ (BOOL)isValidString:(NSString *)aString{
    if ([aString isKindOfClass:[NSString class]] && [aString length] > 0){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isValidArray:(NSArray *)aArray{
    if ([aArray isKindOfClass:[NSArray class]]){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isValidDictionary:(NSDictionary *)aDictionary{
    if ([aDictionary isKindOfClass:[NSDictionary class]]){
        return YES;
    }else{
        return NO;
    }
}

@end
