//
//  UIImageView+WGHTTP.h
//  iWork
//
//  Created by Adele on 12/15/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WGHTTP)

- (void)wg_loadImageFromURL:(NSString *)urlStr placeholder:(UIImage *)image;

@end
