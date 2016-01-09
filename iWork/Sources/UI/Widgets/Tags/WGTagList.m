//
//  WGTagList.m
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGTagList.h"

#import <QuartzCore/QuartzCore.h>

#import "UIColor+WGThemeColors.h"

#import "WGDetailIndustryModel.h"

#define CORNER_RADIUS 10.0f
#define LABEL_MARGIN 5.0f
#define BOTTOM_MARGIN 5.0f
#define FONT_SIZE 13.0f
#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING 3.0f
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)

#define BORDER_WIDTH 0.5f


@implementation WGTagList

@synthesize view, textArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
    }
    return self;
}

- (float)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;

    return [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    lblBackgroundColor = color;
    [self display];
}

- (float)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    for (WGDetailIndustryModel *model in textArray) {
        CGSize textSize = [model.industryName sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:UILineBreakModeWordWrap];
        textSize.width += HORIZONTAL_PADDING*2;
        textSize.height += VERTICAL_PADDING*2;
        UILabel *label = nil;
        if (!gotPreviousFrame) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            newRect.size = textSize;
            label = [[UILabel alloc] initWithFrame:newRect];
        }
        previousFrame = label.frame;
        gotPreviousFrame = YES;
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        if (!lblBackgroundColor) {
            [label setBackgroundColor:[UIColor wg_themeWhiteColor]];
        } else {
            [label setBackgroundColor:lblBackgroundColor];
        }
        [label setTextColor:[UIColor wg_themeDarkGrayColor]];
        [label setText:model.industryName];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setShadowOffset:TEXT_SHADOW_OFFSET];
        [label.layer setMasksToBounds:YES];
        [label.layer setCornerRadius:CORNER_RADIUS];
        [label.layer setBorderColor:[UIColor wg_themeMoreLightGrayColor].CGColor];
        [label.layer setBorderWidth: BORDER_WIDTH];
        [self addSubview:label];
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
    return totalHeight;
}

- (CGSize)fittedSize
{
    return sizeFit;
}

@end
