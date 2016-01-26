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

#import "WGTagList.h"
#import "WGFunctionModel.h"

@interface WGFunctionView()<XXNibBridge>

@property (strong, nonatomic) WGTagList *tagList;
@property (weak, nonatomic) IBOutlet UIView *tagsView;

@end

@implementation WGFunctionView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.tagList = [[WGTagList alloc] initWithFrame:CGRectMake(0, 0, self.tagsView.width, 0.0f)];
    [self.tagsView addSubview:self.tagList];
}

- (CGFloat)viewHeightbyFunctionsArray:(NSArray *)functions{

    NSMutableArray *array = [NSMutableArray array];
    for (WGFunctionModel *functionModel in functions) {
        [array addObject:functionModel.functionsName];
    }
//    self.functionsLabel.text = [array componentsJoinedByString:@"."];
//
//    return self.functionsLabel.height+40;
    return [self.tagList setTags:array]+50;
}

@end
