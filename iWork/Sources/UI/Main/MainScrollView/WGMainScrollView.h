//
//  WGMainScrollView.h
//  iWork
//
//  Created by Adele on 12/10/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SynthesizeSingletonForArc.h"

@interface WGMainScrollView : UIScrollView

ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(WGMainScrollView)

- (void)initWithViews:(NSArray *)items;

@end
