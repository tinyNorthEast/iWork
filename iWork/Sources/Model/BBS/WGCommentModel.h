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
//"c_from_id" = 100061;
//"c_main_id" = 24;
//content = "\U6d4b\U8bd5\U6d41\U8a00\U7ec8\U7ed3\U8005";
//"create_time" = 1452409843000;
//fromName = "\U671f\U95f4";
//objId = 5;
//pic = "http://7xoors.com1.z0.glb.clouddn.com/PNG_20160111102852";
//}

@interface WGCommentModel : WGBaseModel

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,copy)NSString<Optional> *content;
@property (nonatomic,strong)NSNumber<Optional> *create_time;
@property (nonatomic,copy)NSString<Optional> *fromName;
@property (nonatomic,strong)NSNumber<Optional> *c_from_id;
@property (nonatomic,strong)NSNumber<Optional> *c_main_id;

@end
