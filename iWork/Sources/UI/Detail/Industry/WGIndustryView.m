//
//  WGIndustryView.m
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGIndustryView.h"

#import <XXNibBridge.h>

#import "UIViewAdditions.h"

#import "WGTagList.h"

@interface WGIndustryView()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIView *tagsView;

@end

@implementation WGIndustryView

- (void)setTagsArray:(NSArray *)tagsArray{
    WGTagList *tagList = [[WGTagList alloc] initWithFrame:CGRectMake(self.tagsView.left, self.tagsView.top, self.tagsView.width, 0.0f)];
    [tagList setTags:tagsArray];
    [self.tagsView addSubview:tagList];
}

@end
