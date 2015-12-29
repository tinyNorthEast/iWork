//
//  WGDateFormat.m
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDateFormatter.h"

@implementation WGDateFormatter

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(WGDateFormatter)

- (NSString *)formatTime:(NSNumber *)time
{
    // 由于时间是以毫秒提供，估需要除以1000
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue] / 1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    return [formatter stringFromDate:date];
}


@end
