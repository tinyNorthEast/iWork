//
//  DBRestriction.h
//  Test
//
//  Created by adele on 14-9-13.
//  Copyright (c) 2014年 adele. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DBRestrictionTypeEQ,      //=
    DBRestrictionTypeGT,      //>
    DBRestrictionTypeGE,      //>=
    DBRestrictionTypeLT,      //<
    DBRestrictionTypeLE,      //<=
    DBRestrictionTypeLIKEANY, //%value%
    DBRestrictionTypeLIKESTART,//value%
    DBRestrictionTypeLIKEEND, //%value
    //    DBRestrictionTypeAND,
    //    DBRestrictionTypeOR,
    //    DBRestrictionTypeIN,
}DBRestrictionType;
typedef enum {
    DBRestrictionOrderASC,
    DBRestrictionOrderDESC
}DBRestrictionOrder;

@interface DBRestriction : NSObject
-(instancetype)initWithName:(NSString *)name value:(NSString *)vl restrictionType:(DBRestrictionType)type;
-(void)pageIndex:(int)index pageSize:(int)size;
-(void)andPropertyName:(NSString *)name value:(NSString *)vl restrictionType:(DBRestrictionType)type;
-(void)orPropertyName:(NSString *)name value:(NSString *)vl restrictionType:(DBRestrictionType)type;
//DBRestrictionTypeASC,DBRestrictionTypeDESC
-(void)orderPropertyName:(NSString *)name restrictionOrder:(DBRestrictionOrder)type;

-(NSString *)makeRestrictionWithAlias:(NSString *)alias;

@end
