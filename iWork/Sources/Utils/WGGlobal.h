//
//  WGGlobal.h
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SynthesizeSingletonForArc.h"

@interface WGGlobal : NSObject

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(WGGlobal)

@property (nonatomic, copy) NSString *userToken;

- (void)saveToken:(NSString *)token;

- (void)clearToken;

@end
