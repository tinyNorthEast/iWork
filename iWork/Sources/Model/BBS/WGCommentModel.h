//
//  WGCommentModel.h
//  iWork
//
//  Created by Adele on 12/21/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGCommentModel <NSObject>
@end

@interface WGCommentModel : WGBaseModel

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,copy)NSString<Optional> *content;
@property (nonatomic,strong)NSNumber<Optional> *create_time;

@end
