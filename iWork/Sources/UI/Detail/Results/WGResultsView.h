//
//  WGResultsView.h
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGResultsView : UIView

@property(nonatomic, strong) NSNumber *objId;

- (CGFloat)viewHeightbyResultsArray:(NSArray *)results;

@end
