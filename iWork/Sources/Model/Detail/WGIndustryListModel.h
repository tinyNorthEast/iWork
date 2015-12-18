//
//  WGIndustryListModel.h
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

//industryList: [
//    {
//    objId: 3,
//    createTime: 1450349580079,
//    industryName: "法务"
//    }

@protocol WGIndustryListModel <NSObject>
@end

@interface WGIndustryListModel : WGBaseModel

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *createTime;
@property (nonatomic,copy)NSString<Optional> *industryName;

@end
