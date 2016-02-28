//
//  WGMainTableViewCell.h
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGHunterModel;

@interface WGMainCell : UITableViewCell

@property (nonatomic, strong) WGHunterModel *hunter;

@property (weak, nonatomic) IBOutlet UIButton *pariseButton;

@property (nonatomic, copy) void (^selectBBS)(WGMainCell *cell);
@property (nonatomic, copy) void (^selectCell)(WGMainCell *cell,BOOL ifPraised);

@end
