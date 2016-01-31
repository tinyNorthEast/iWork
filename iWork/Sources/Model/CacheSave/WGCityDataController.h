//
//  WGCityDataController.h
//  iWork
//
//  Created by Adele on 1/31/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City;

@interface WGCityDataController : NSObject


+ (id)sharedInstance;

- (NSArray *)fetchCitys;
- (void)insertCity:(NSArray *)array;

@end
