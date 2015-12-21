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
@property (strong, nonatomic) WGTagList *tagList;
@property (weak, nonatomic) IBOutlet UIView *tagsView;

@end

@implementation WGIndustryView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.tagList = [[WGTagList alloc] initWithFrame:CGRectMake(self.tagsView.left, self.tagsView.top, self.tagsView.width, 0.0f)];
    [self.tagsView addSubview:self.tagList];
}

- (void)setTagsArray:(NSArray *)tagsArray{
    [self.tagList setTags:tagsArray];
}

@end
