//
//  WGNotifiCategoryListModel.h
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGNotifiCategoryModel.h"

//int n_type;// 1.评论 2.权限审批 3.关注 4.系统消息
typedef NS_ENUM(NSUInteger, WGNOTIFICATIONCATEGORY) {
    WGNOTIFICATIONCATEGORY_BBS = 1,
    WGNOTIFICATIONCATEGORY_PERMISION,
    WGNOTIFICATIONCATEGORY_FOCUS,
    WGNOTIFICATIONCATEGORY_SYSTEM
};

@interface WGNotifiCategoryListModel : WGBaseModel

@property(nonatomic,strong)NSArray <Optional,WGNotifiCategoryModel> *data;

@end
