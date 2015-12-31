//
//  WGTagList.h
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGTagList : UIView
{
    UIView *view;
    NSArray *textArray;
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSArray *textArray;

- (void)setLabelBackgroundColor:(UIColor *)color;
- (float)setTags:(NSArray *)array;
- (float)display;
- (CGSize)fittedSize;
@end
