//
//  WGResultModel.h
//  iWork
//
//  Created by Adele on 1/2/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGBaseModel.h"

@interface WGResultModel : WGBaseModel

//annualSalary = 11111;
//companyName = xxxxx;
//headhunterId = 16;
//objId = 10;
//position = "\U7ecf\U7406";

@property (nonatomic,strong)NSNumber<Optional> *objId;
@property (nonatomic,copy)NSString<Optional> *companyName;
@property (nonatomic,copy)NSString<Optional> *position;
@property (nonatomic,copy)NSString<Optional> *annualSalary;

@end
