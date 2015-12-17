//
//  WGIntroductionView.m
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGIntroductionView.h"

#import <XXNibBridge.h>

@interface WGIntroductionView()<XXNibBridge>

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@end

@implementation WGIntroductionView

- (void)setDescribeStr:(NSString *)describeStr{
    self.describeLabel.text = describeStr;
}
@end
