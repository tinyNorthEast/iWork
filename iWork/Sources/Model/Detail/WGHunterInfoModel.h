//
//  WGHunterInfoModel.h
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@interface WGHunterInfoModel : WGBaseModel


//objId: 3,
//realName: "2",
//phone: "18201413267",
//companyName: "撒旦法",
//position: "撒旦法",
//workTime: 1448035200000,
//phone400: "234234",
//pic: "http://www.7xoors.com1.z0.glb.clouddn.com/PNG-20151214211338-884.png",
//describe: "阿萨德发斯蒂芬",
//ranking: 0,
//participated: 0,
//commentCount: 0,
//industryList: [ ],
//functionsList: [ ]


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

@end
