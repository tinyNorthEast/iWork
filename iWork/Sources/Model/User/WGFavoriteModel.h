//
//  WGFavoriteModel.h
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGFavoriteModel <NSObject>

@end

@interface WGFavoriteModel : WGBaseModel

@property (nonatomic, strong) NSNumber<Optional> *objId;
@property (nonatomic, strong) NSNumber<Optional> *attention_from_id;
@property (nonatomic, strong) NSNumber<Optional> *attention_to_id;
@property (nonatomic, strong) NSNumber<Optional> *create_time;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *zh_name;

@end
