//
//  WGNotificationCell.h
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGNotificationModel;

typedef void (^ ControlPermission)(NSNumber *state);

@interface WGNotificationCell : UITableViewCell

@property(nonatomic, strong) WGNotificationModel *notification;

@property(nonatomic, strong) NSNumber *notify_type;

@property(nonatomic, copy) ControlPermission controlPermission;

@end
