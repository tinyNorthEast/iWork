//
//  WGDescribeModel.h
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"
@protocol WGDescribeModel<NSObject>
@end

@interface WGDescribeModel : WGBaseModel

@property (nonatomic, copy) NSString *describe;


@end
