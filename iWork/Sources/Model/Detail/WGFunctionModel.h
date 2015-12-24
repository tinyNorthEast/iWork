//
//  WGFunctionModel.h
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGFunctionModel <NSObject>
@end


@interface WGFunctionModel : WGBaseModel

//createTime = 1450955065013;
//functionsName = "\U804c\U80fd1";
//objId = 1;

@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, copy) NSString *functionsName;
@property (nonatomic, strong) NSNumber *objId;

@end
