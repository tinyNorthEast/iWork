//
//  WGNotificationListModel.h
//  iWork
//
//  Created by Adele on 12/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGNotificationModel.h"

@interface WGNotificationListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGNotificationModel> *data;

@end
