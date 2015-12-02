//
//  WGToolBarView.h
//  iWork
//
//  Created by Adele on 12/2/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelButtonActionBlock) ();
typedef void (^ConfirmButtonActionBlock) ();

@interface WGToolBarView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) CancelButtonActionBlock cancelBlock;

@property (nonatomic, copy) ConfirmButtonActionBlock confirmBlock;

@end
