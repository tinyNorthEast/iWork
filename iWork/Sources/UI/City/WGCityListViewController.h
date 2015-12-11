//
//  WGCityListViewController.h
//  iWork
//
//  Created by Adele on 12/4/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGCityModel;

@interface WGCityListViewController : UIViewController

@property (nonatomic, copy) void (^selectCity)(WGCityModel *city);

@end
