//
//  WGResultsView.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGResultsView.h"

#import <XXNibBridge.h>

#import "UIViewAdditions.h"
#import "UIFont+WGThemeFonts.h"
#import "UIColor+WGThemeColors.h"

#import "WGGlobal.h"
#import "WGResultModel.h"
#import "WGApplyAuthRequest.h"

@interface WGResultsView()<XXNibBridge>
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultViewHeight;

@end

@implementation WGResultsView

- (CGFloat)viewHeightbyResultsArray:(NSArray *)results{
    int height = 0;
    int line = 0;
    
    for (int i = 0; i< results.count; i++) {
        NSDictionary *dic = results[i];
        
        height += 20;
        line +=i;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, line, 10, 10)];
        imageView.image = [UIImage imageNamed:@"bbs_timeicon"];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right, imageView.top, 100, 20)];
        timeLabel.centerY = imageView.centerY;
        timeLabel.font = [UIFont kFontSize14];
        timeLabel.textColor = [UIColor wg_themeLightGrayColor];
        timeLabel.text = dic[@"groupDate"];
        [self.resultView addSubview:imageView];
        [self.resultView addSubview:timeLabel];
        
        NSArray *lists = dic[@"list"];
        for (int x = 0; x < lists.count; x++) {
            WGResultModel *resultModel = [[WGResultModel alloc] initWithDictionary:lists[i] error:nil];
            line += x+1;
            UILabel *compayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (x+1)*20, self.resultView.width*2/5, 20)];
            compayLabel.text = resultModel.companyName;
            compayLabel.font = [UIFont kFontSize14];
            compayLabel.textColor = [UIColor wg_themeDarkGrayColor];
            [self.resultView addSubview:compayLabel];
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(compayLabel.right, compayLabel.top, self.resultView.width*1.6/5, 20)];
            positionLabel.font = [UIFont kFontSize14];
            positionLabel.textColor = [UIColor wg_themeDarkGrayColor];
            positionLabel.text = resultModel.position;
            [self.resultView addSubview:positionLabel];
            
            UILabel *salaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(positionLabel.right, compayLabel.top, self.resultView.width*1.4/5, 20)];
            salaryLabel.font = [UIFont kFontSize14];
            salaryLabel.textColor = [UIColor wg_themeDarkGrayColor];
            salaryLabel.textAlignment = NSTextAlignmentRight;
            salaryLabel.text = [NSString stringWithFormat:@"%@万/年薪",resultModel.annualSalary];
            [self.resultView addSubview:salaryLabel];
            
            height += 20*(x+1);
        }
    }
    self.resultViewHeight.constant = height;
    
    return 50+height+70;
}

#pragma mark - IBAcion
- (BOOL)isSignIn{
    return ([[WGGlobal sharedInstance] userToken].length>0?YES:NO);
}
- (IBAction)openPermission:(id)sender {
    if ([self isSignIn]) {
//        WGApplyAuthRequest *request = [WGApplyAuthRequest alloc] initWithHunterId:<#(NSNumber *)#> hr_mail:<#(NSString *)#>
        
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [[self viewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

@end
