//
//  WGDBManager.m
//  iWork
//
//  Created by Adele on 12/23/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGDBManager.h"

@implementation WGDBManager

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(WGDBManager)

- (void )getIndustryList:(void (^)(NSMutableArray *array))block{
    
}

-(void)insertOrUpdateFlightModel:(WGIndustryModel *)aModel
                         success:(void (^)(WGIndustryModel *model))success
                         failure:(void (^)(DBAccessResultType result))failure{
    
}

@end
