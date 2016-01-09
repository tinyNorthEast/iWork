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
        
        
        UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(0,height,self.describeView.width,20)];//后面还会重新设置其size。
       
//        [alabel setNumberOfLines:0];
        alabel.textColor = [UIColor wg_themeDarkGrayColor];
        NSString *s = [NSString stringWithFormat:@"%d.%@",index+1,aModel.describe];
        alabel.text = s;
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        alabel.font = font;
//        CGSize size = CGSizeMake(320,2000);
//        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//        [alabel setFrame:CGRectMake(0, 0, labelsize.width, labelsize.height)];
     
        height += alabel.height;
        
        [self.describeView addSubview:alabel];
    }
    return height+50;
}
@end
