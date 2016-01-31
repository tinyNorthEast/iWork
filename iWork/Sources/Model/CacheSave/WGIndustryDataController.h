//
//  WGIndustryDataController.h
//  iWork
//
//  Created by Adele on 1/31/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Industry;

@interface WGIndustryDataController : NSObject

+ (id)sharedInstance;

- (NSArray *)fetchIndustry;
- (void)insertIndustry:(NSArray *)array;

@end
