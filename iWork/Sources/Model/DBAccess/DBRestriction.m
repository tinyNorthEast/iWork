//
//  DBRestriction.m
//  Test
//
//  Created by adele on 14-9-13.
//  Copyright (c) 2014年 adele. All rights reserved.
//

#define kQueryPrefix @"kQueryPrefix"
#define kQueryPrefixQ @"kQueryPrefix."

#import "DBRestriction.h"

@interface DBRestriction()
@property(nonatomic)int pageNo;
@property(nonatomic)int pageSize;
@property(nonatomic,strong)NSMutableString *restriction;
@property(nonatomic,strong)NSMutableString *orderStr;

@end

@implementation DBRestriction

-(instancetype)init{
    if (self = [super init]) {
        _restriction = [NSMutableString string];
        _orderStr = [NSMutableString string];
        return self;
    }
    return nil;
}

-(instancetype)initWithName:(NSString *)name value:(NSString *)vl restrictionType:(DBRestrictionType)type{
    if (self = [super init]) {
        if (name.length > 0 && vl.length > 0) {
            NSString *oprt = [self operatorWithValue:vl restrictionType:type];
            _restriction = [NSMutableString stringWithFormat:@" WHERE %@.%@ %@ ",kQueryPrefix,name,oprt];
        }else{
            _restriction = [NSMutableString string];
        }
        _orderStr = [NSMutableString string];
        return self;
    }
    return nil;
}

-(NSString *)operatorWithValue:(NSString *)vl restrictionType:(DBRestrictionType)type{
    switch (type) {
        case DBRestrictionTypeEQ:
            return [NSString stringWithFormat:@"= '%@' ",vl];
            break;
        case DBRestrictionTypeGE:
            return [NSString stringWithFormat:@">= '%@' ",vl];
            break;
        case DBRestrictionTypeGT:
            return [NSString stringWithFormat:@"> '%@' ",vl];
            break;
        case DBRestrictionTypeLE:
            return [NSString stringWithFormat:@"<= '%@' ",vl];
            break;
        case DBRestrictionTypeLT:
            return [NSString stringWithFormat:@"< '%@' ",vl];
            break;
        case DBRestrictionTypeLIKEANY:
            return [NSString stringWithFormat:@"LIKE '%%%@%%' ",vl];
            break;
        case DBRestrictionTypeLIKEEND:
            return [NSString stringWithFormat:@"LIKE '%%%@' ",vl];
            break;
        case DBRestrictionTypeLIKESTART:
            return [NSString stringWithFormat:@"LIKE '%@%%' ",vl];
            break;
        default:
            return [NSString stringWithFormat:@"LIKE '%%%@%%' ",vl];
            break;
    }
    return @"";
}

-(void)andPropertyName:(NSString *)name value:(NSString *)vl restrictionType:(DBRestrictionType)type{
    if (vl.length > 0) {
        NSString *oprt = [self operatorWithValue:vl restrictionType:type];
        if (self.restriction.length==0) {
            [self.restriction appendFormat:@" WHERE %@.%@ %@",kQueryPrefix,name,oprt];
        }else{
            [self.restriction appendFormat:@" AND %@.%@ %@ ",kQueryPrefix,name,oprt];
        }
    }
}
-(void)orPropertyName:(NSString *)name value:(NSString *)vl restrictionType:(DBRestrictionType)type{
    if (vl.length > 0) {
        NSString *oprt = [self operatorWithValue:vl restrictionType:type];
        if (self.restriction.length==0) {
            [self.restriction appendFormat:@" WHERE %@.%@ %@",kQueryPrefix,name,oprt];
        }else{
            [self.restriction appendFormat:@" OR %@.%@ %@ ",kQueryPrefix,name,oprt];
        }
    }
}
//DBRestrictionTypeASC,DBRestrictionTypeDESC
-(void)orderPropertyName:(NSString *)name restrictionOrder:(DBRestrictionOrder)type;{
    if (type == DBRestrictionOrderASC) {
        [self.orderStr appendFormat:@" ORDER BY %@.%@ ASC ",kQueryPrefix,name];
    }else if (type == DBRestrictionOrderDESC){
        [self.orderStr appendFormat:@" ORDER BY %@.%@ DESC ",kQueryPrefix,name];
    }
}

-(void)pageIndex:(int)index pageSize:(int)size{
    self.pageNo = index*size;
    self.pageSize = size;
}

-(NSString *)makeRestrictionWithAlias:(NSString *)alias{
    //maybe check gramer

    if (self.orderStr.length > 0) {
        [self.restriction appendString:self.orderStr];
    }
    if (self.pageSize > 0) {
        [self.restriction appendFormat:@" LIMIT %d OFFSET %d",self.pageSize,self.pageNo];
    }
    
    if (!alias || alias.length == 0) {
        NSString *whe = [self.restriction stringByReplacingOccurrencesOfString:kQueryPrefixQ withString:@""];
        return whe;
    }
    
    return [self.restriction stringByReplacingOccurrencesOfString:kQueryPrefix withString:alias];
}

@end