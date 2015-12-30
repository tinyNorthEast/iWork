//
//  WGMenuBar.h
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGMenuBarDelegate <NSObject>

- (void)clickMenuButtonAtIndex:(NSInteger)index;

@end

@interface WGMenuBar : UIView

@property (nonatomic,assign) id <WGMenuBarDelegate> delegate;

- (void)initMenuItems:(NSArray *)items;

- (void)changeButtonStateAtIndex:(NSInteger)aIndex;

- (void)clickButtonAtIndex:(NSInteger)aIndex;

@end
