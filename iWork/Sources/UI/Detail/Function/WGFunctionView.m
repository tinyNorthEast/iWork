//
//  WGFunctionView.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGFunctionView.h"

#import <XXNibBridge.h>

@interface WGFunctionView()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UILabel *functionLabel;

@end

@implementation WGFunctionView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setFunctionsStr:(NSString *)functionsStr{
    self.functionLabel.text = functionsStr;
}

@end
