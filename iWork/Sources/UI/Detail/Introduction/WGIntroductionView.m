//
//  WGIntroductionView.m
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGIntroductionView.h"

#import <XXNibBridge.h>

#import "UIViewAdditions.h"
#import "UIColor+WGThemeColors.h"

#import "WGDescribeModel.h"

@interface WGIntroductionView()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIView *describeView;

@end

@implementation WGIntroductionView

- (CGFloat)viewHeightbyDescribeArray:(NSArray *)describes{
    float height = 0;
    
    for (int index = 0; index < describes.count; index++) {
        WGDescribeModel *aModel = describes[index];
        
        UILabel *alabel = [[UILabel alloc] init];//后面还会重新设置其size。
        [alabel setNumberOfLines:0];
        alabel.textColor = [UIColor wg_themeDarkGrayColor];
        NSString *describeStr = [NSString stringWithFormat:@"%d.%@",index+1,aModel.describe];
        alabel.text = describeStr;
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        alabel.font = font;
        
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGRect rect = [describeStr boundingRectWithSize:CGSizeMake(self.describeView.width, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        [alabel setFrame:CGRectMake(0, height+2, self.describeView.width, rect.size.height)];
     
        height += alabel.height;
        
        [self.describeView addSubview:alabel];
    }
    return height+50;
}
@end
