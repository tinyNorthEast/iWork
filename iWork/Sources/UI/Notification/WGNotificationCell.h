//
//  WGNotificationCell.h
//  iWork
//
//  Created by Adele on 12/28/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGNotificationModel;

@interface WGNotificationCell : UITableViewCell

@property(nonatomic, strong) WGNotificationModel *notification;

@end
