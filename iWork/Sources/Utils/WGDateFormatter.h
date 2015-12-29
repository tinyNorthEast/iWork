//
//  WGDateFormat.h
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SynthesizeSingletonForArc.h"

@interface WGDateFormatter : NSObject

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(WGDateFormatter)

- (NSString *)formatTime:(NSNumber *)time;

@end
