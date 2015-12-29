//
//  WGCodeModel.h
//  iWork
//
//  Created by Adele on 12/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGCodeModel <NSObject>

@end

@interface WGCodeModel : WGBaseModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSNumber *status;

@end
