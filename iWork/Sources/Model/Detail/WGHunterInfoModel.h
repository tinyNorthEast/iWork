//
//  WGHunterInfoModel.h
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGIndustryListModel.h"

@interface WGHunterInfoModel : WGBaseModel


//headhunterInfo: {
//objId: 16,
//realName: "廖端永",
//phone: "18201413265",
//companyName: "搜狐",
//position: "高级开发",
//workTime: 1448380800000,
//phone400: "0101234",
//pic: "http://www.7xoors.com1.z0.glb.clouddn.com/JPG-20151214210947-312.jpg",
//describe: "阿斯顿飞洒",
//ranking: 1,
//participated: 1,
//commentCount: 2,
//industryList: [
//    {
//    objId: 3,
//    createTime: 1450349580079,
//    industryName: "法务"
//    }
//               ],
//functionsList: [
//    {
//    objId: 82,
//    createTime: 1450349580082,
//    functionsName: "外部审计-四大"
//    },
//    {
//    objId: 2,
//    createTime: 1450349580082,
//    functionsName: "洽谈"
//    }
//                ]
//}

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *realName;
@property (nonatomic,copy)NSString<Optional> *phone;
@property (nonatomic,copy)NSString<Optional> *companyName;
@property (nonatomic,copy)NSString<Optional> *position;
@property (nonatomic,copy)NSString<Optional> *workTime;
@property (nonatomic,copy)NSString<Optional> *phone400;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,copy)NSString<Optional> *describe;
@property (nonatomic,copy)NSString<Optional> *ranking;
@property (nonatomic,copy)NSString<Optional> *participated;
@property (nonatomic,copy)NSString<Optional> *commentCount;
@property (nonatomic,copy)NSArray<Optional,WGIndustryListModel> *industryList;

@end
