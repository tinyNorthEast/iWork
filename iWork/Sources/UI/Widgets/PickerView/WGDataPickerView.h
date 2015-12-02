//
//  WGDataPickerView.h
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PickerViewSelectBlock) (NSInteger selectRow);

typedef void (^PickerViewCancelBlock) ();

@interface WGDataPickerView : UIView

@property (nonatomic, assign) BOOL autoHidden;


@property (nonatomic, copy) NSString *barTitle;

@property (nonatomic, copy) NSArray *dataArray;


- (void)showSelectDate:(PickerViewSelectBlock)aDatePickerViewSelectBlock
                cancel:(PickerViewCancelBlock)aDatePickerViewCancelBlock;

- (void)maskSubview;

- (void)setSelectIndex:(NSInteger)index;
- (void)showInView:(UIView *)view;

@end
