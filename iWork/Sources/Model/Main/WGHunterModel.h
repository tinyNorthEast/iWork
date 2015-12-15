//
//  WGHunterModel.h
//  iWork
//
//  Created by Adele on 12/15/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGHunterModel <NSObject>
@end

@interface WGHunterModel : WGBaseModel

//@property (nonatomic,copy)NSString<Optional> *id;
@property (nonatomic,copy)NSString<Optional> *realName;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,copy)NSNumber<Optional> *ranking;
@property (nonatomic,copy)NSNumber<Optional> *commentCount;

@end
