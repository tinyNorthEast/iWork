//
//  WGNotificationModel.h
//  iWork
//
//  Created by Adele on 12/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@protocol WGNotificationModel <NSObject>
@end
//objId":1,"user_id":100022,"content":"测试消息","create_time":1451200167000,"status":1
@interface WGNotificationModel : WGBaseModel

@property (nonatomic, strong) NSNumber *objId;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *create_time;
@property (nonatomic, strong) NSNumber *status;

@end
