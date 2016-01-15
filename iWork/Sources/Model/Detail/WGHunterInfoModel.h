//
//  WGHunterInfoModel.h
//  iWork
//
//  Created by Adele on 12/17/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

#import "WGFunctionModel.h"
#import "WGDescribeModel.h"
#import "WGDetailIndustryModel.h"

@interface WGHunterInfoModel : WGBaseModel


//data =     {
//    commentList =         (
//                           {
//                               "c_from_id" = 1;
//                               "c_to_user_id" = 16;
//                               content = "\U4f60\U597d\U5417";
//                               objId = 1;
//                               toUserName = "\U6d4b\U8bd5\U4eba\U5458";
//                           },
//                           {
//                               "c_from_id" = 4;
//                               "c_to_user_id" = 16;
//                               content = "\U4e0d\U597d\U5e05";
//                               objId = 2;
//                               toUserName = "\U6d4b\U8bd5\U4eba\U5458";
//                           }
//                           );
//    headhunterInfo =         {
//        commentCount = 2;
//        companyName = "\U641c\U72d0";
//        describeList =             (
//                                    {
//                                        describe = "\U6d4b\U8bd51";
//                                        headhunterId = 16;
//                                        objId = 1;
//                                        status = 1;
//                                    },
//                                    {
//                                        describe = "\U6d4b\U8bd52";
//                                        headhunterId = 16;
//                                        objId = 2;
//                                        status = 1;
//                                    },
//                                    {
//                                        describe = "\U6d4b\U8bd53";
//                                        headhunterId = 16;
//                                        objId = 3;
//                                        status = 1;
//                                    },
//                                    {
//                                        describe = "\U6d4b\U8bd54";
//                                        headhunterId = 16;
//                                        objId = 4;
//                                        status = 1;
//                                    },
//                                    {
//                                        describe = "\U6d4b\U8bd55";
//                                        headhunterId = 16;
//                                        objId = 5;
//                                        status = 1;
//                                    }
//                                    );
//        functionsList =             (
//                                     {
//                                         createTime = 1450955065013;
//                                         functionsName = "\U804c\U80fd1";
//                                         objId = 1;
//                                     },
//                                     {
//                                         createTime = 1450955065013;
//                                         functionsName = "\U804c\U80fd2";
//                                         objId = 2;
//                                     }
//                                     );
//        industryList =             (
//                                    {
//                                        createTime = 1450955065011;
//                                        industryName = "\U7684\U6492\U65e6\U6cd5";
//                                        objId = 3;
//                                    }
//                                    );
//        isAuth = 0;
//        objId = 16;
//        participated = 1;
//        phone = 18201413265;
//        phone400 = 0101234;
//        pic = "http://www.7xoors.com1.z0.glb.clouddn.com/JPG-20151214210947-312.jpg";
//        position = "\U9ad8\U7ea7\U5f00\U53d1";
//        ranking = 1;
//        realName = "\U5ed6\U7aef\U6c38";
//        workTime = 1448380800000;
//    };
//    performanceList =         (
//                               {
//                                   groupDate = "2015/12";
//                                   list =                 (
//                                                           {
//                                                               annualSalary = 11111;
//                                                               companyName = xxxxx;
//                                                               headhunterId = 16;
//                                                               objId = 10;
//                                                               position = "\U7ecf\U7406";
//                                                           }
//                                                           );
//                               }
//                               );
//};
//infoCode = 0;
//message = "\U83b7\U53d6\U6570\U636e\U6210\U529f";
//}

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *realName;
@property (nonatomic,copy)NSString<Optional> *phone;
@property (nonatomic,copy)NSString<Optional> *companyName;
@property (nonatomic,copy)NSString<Optional> *position;
@property (nonatomic,copy)NSString<Optional> *workTime;
@property (nonatomic,copy)NSString<Optional> *phone400;
@property (nonatomic,copy)NSString<Optional> *pic;
@property (nonatomic,copy)NSArray<Optional,WGDescribeModel> *describeList;
@property (nonatomic,copy)NSString<Optional> *ranking;
@property (nonatomic,copy)NSString<Optional> *participated;
@property (nonatomic,strong)NSNumber<Optional> *commentCount;
@property (nonatomic,copy)NSArray<Optional,WGDetailIndustryModel> *industryList;
@property (nonatomic,copy)NSArray<Optional,WGFunctionModel> *functionsList;
@property (nonatomic,strong)NSNumber<Optional> *userId;
@property (nonatomic,strong)NSNumber<Optional> *isAttention;

@end
