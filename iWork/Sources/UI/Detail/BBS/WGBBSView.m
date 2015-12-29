//
//  WGBBSView.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBBSView.h"

#import <XXNibBridge.h>

#import "WGCommentModel.h"

@interface WGBBSView()<XXNibBridge>

@end

@implementation WGBBSView

- (CGFloat)viewHeightbyCommentsArray:(NSArray *)comments{
    if (comments.count==0) {
        return 40+50;
    }else if (comments.count == 1){
        return 40+50+60;
    }else if (comments.count ==2){
        return 40+50+60*2;
    }
    return 0;
}

@end
