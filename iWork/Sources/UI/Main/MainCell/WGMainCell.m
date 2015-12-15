
//
//  WGMainTableViewCell.m
//  iWork
//
//  Created by Adele on 12/3/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGMainCell.h"

#import <XXNibBridge.h>

#import "WGHunterListModel.h"

@interface WGMainCell()<XXNibBridge>

@end

@implementation WGMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setHunters:(WGHunterListModel *)hunters{
    
}
- (void)setHunters:(WGHunterListModel *)hunters byIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }
}

- (IBAction)commentAction:(id)sender {
    if (self.selectBBS) {
        self.selectBBS();
    }
}

@end
