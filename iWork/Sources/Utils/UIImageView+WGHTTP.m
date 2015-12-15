//
//  UIImageView+WGHTTP.m
//  iWork
//
//  Created by Adele on 12/15/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "UIImageView+WGHTTP.h"

#import <UIImageView+AFNetworking.h>

@implementation UIImageView (WGHTTP)

- (void)wg_loadImageFromURL:(NSString *)urlStr placeholder:(UIImage *)image {
    [self setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:image];
}

@end
