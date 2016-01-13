//
//  WGFunctionView.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGFunctionView.h"

#import <XXNibBridge.h>

#import "UIViewAdditions.h"

#import "WGFunctionModel.h"

@interface WGFunctionView()<XXNibBridge>

@property (weak, nonatomic) IBOutlet UILabel *functionsLabel;

@end

@implementation WGFunctionView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (CGFloat)viewHeightbyFunctionsArray:(NSArray *)functions{

    NSMutableArray *array = [NSMutableArray array];
    for (WGFunctionModel *functionModel in functions) {
        [array addObject:functionModel.functionsName];
    }
    self.functionsLabel.text = [array componentsJoinedByString:@"."];

    return self.functionsLabel.height+40;
}

@end
