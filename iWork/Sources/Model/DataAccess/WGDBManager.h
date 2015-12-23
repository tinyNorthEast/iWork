//
//  WGDBManager.h
//  iWork
//
//  Created by Adele on 12/23/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBAccessQueue.h"
#import "SynthesizeSingletonForArc.h"

#import "WGIndustryModel.h"

@interface WGDBManager : NSObject

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(WGDBManager)


- (void )getIndustryList:(void (^)(NSMutableArray *array))block;

-(void)insertOrUpdateFlightModel:(WGIndustryModel *)aModel
                         success:(void (^)(WGIndustryModel *model))success
                         failure:(void (^)(DBAccessResultType result))failure;

@end
