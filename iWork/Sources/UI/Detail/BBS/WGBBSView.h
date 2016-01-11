//
//  WGBBSView.h
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBBSView : UIView
@property (nonatomic, strong) NSNumber *objId;
- (CGFloat)viewHeightbyCommentsArray:(NSArray *)comments;

@end
