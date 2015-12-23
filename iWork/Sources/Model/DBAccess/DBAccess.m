//
//  DBAccess.m
//  Test
//
//  Created by adele on 13-11-21.
//  Copyright (c) 2013年 adele. All rights reserved.
//

#import "DBAccess.h"
#import <objc/runtime.h>
#import <sqlite3.h>

#define DBTName @"BDAccessTmpName"
#define DBPrimaryKeyDefault @"tkey"

#define kSTRDoubleMarks @"\""
#define kSQLDoubleMarks @"\"\""
#define kSTRShortMarks  @"'"
#define kSQLShortMarks  @"''"

#define kMaxBusyRetryCount  9000

static  int retryBusyCount;

typedef enum {
    DBExecuteTypeInsert     =   1,
    DBExecuteTypeUpdate,
    DBExecuteTypeQuery,
    DBExecuteTypeCreate,
    DBExecuteTypeDelete,
    DBExecuteTypeTruncate
}DBExecuteType;

typedef enum {
    OCFieldTypeInteger,
    OCFieldTypeFloat,
    OCFieldTypeLong,
    OCFieldTypeDouble,
    OCFieldTypeBool,
    OCFieldTypeShort,
    OCFieldTypeString,
    OCFieldTypeNumber,
    OCFieldTypeDictionary,
    OCFieldTypeArray,
    OCFieldTypeCustomer
}OCFieldType;

@interface DBAccessPropertyModel()
@property (nonatomic,assign) OCFieldType ocFieldType;
@property (nonatomic,copy) NSString *ocFieldTypeName;
@property (nonatomic,copy) NSString* protocol;
@property (nonatomic,assign) BOOL isTransient;
@property (nonatomic,assign) BOOL isCascadeSaveOrUpdate;
//@property (nonatomic,assign) BOOL isCascadeDelete;
@property (nonatomic,assign) BOOL isCascadeAll;
@property (nonatomic,assign) BOOL isMutable;
@property (nonatomic,assign) BOOL isPrimaryKey;
//@property (nonatomic,assign) BOOL isRefKey;
@property (nonatomic,copy) NSString *refKeyName;
@end

@interface DBAccess()
@property(nonatomic,strong)NSString *dbPath;
@property(nonatomic,strong)NSMutableDictionary *classDictionary;
@property(nonatomic,strong)NSArray *kOCTypeList;
@end

@implementation DBAccess{
    sqlite3 *sqlDB;
}


#pragma -mark iniDB,connection
-(DBAccess *)initWithPath:(NSString *)path{
    
    if (self = [super init]) {
        _dbPath = path;
        _classDictionary = [[NSMutableDictionary alloc]initWithCapacity:3];
        _kOCTypeList = @[@"NSString",@"NSArray",@"NSMutableArray",@"NSDictionary",@"NSMutableDictionary",@"NSNumber"];//,@"NSDecimalNumber"
        return self;
    }
    return nil;
    
}

-(DBAccessResultType)open{
    //init something...
    const char *dpath = [self.dbPath UTF8String];
    int result = sqlite3_open(dpath, &sqlDB);
    if (result == SQLITE_OK) {
        [self __setupRetryBusyHandler];
        return DBAccessResultTypeOK;
    }
    DBAccessLog(@"open db error___%d",result);
    sqlite3_close(sqlDB);
    return DBAccessResultTypeOpenDBError;
}

-(DBAccessResultType)openReadOnly{
    const char *dpath = [self.dbPath UTF8String];
    int result = sqlite3_open_v2(dpath, &sqlDB, SQLITE_OPEN_READONLY, NULL);
    if (result == SQLITE_OK) {
        [self __setupRetryBusyHandler];
        return DBAccessResultTypeOK;
    }
    DBAccessLog(@"open read db error___%d",result);
    sqlite3_close(sqlDB);
    return DBAccessResultTypeOpenDBError;
}

-(DBAccessResultType)close{
    int result = sqlite3_close(sqlDB);
    if (result != SQLITE_OK) {
        DBAccessLog(@"close db error___%d",result);
        return DBAccessResultTypeCloseDBError;
    }
    return DBAccessResultTypeOK;
}

-(void)__setupRetryBusyHandler{
    if (_busyRetryCount == 0 && _busyTimeout > 0) {
        sqlite3_busy_timeout(sqlDB, _busyTimeout);
    }else {
        retryBusyCount = _busyRetryCount>0?_busyRetryCount:kMaxBusyRetryCount;
        sqlite3_busy_handler(sqlDB, __setupBusyHandler, sqlDB);
    }
    
}

#pragma -mark utils
extern BOOL isNullD(id value)
{
    if (!value) return YES;
    if ([value isKindOfClass:[NSNull class]]) return YES;
    
    return NO;
}

-(NSString *)toJSONStringWithObject:(id)obj{
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSData *dt = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:dt encoding:NSUTF8StringEncoding];
        return [self stringToSQLFilter:str];
        /*
        if ([str rangeOfString:@"'"].location != NSNotFound) {
            str = [str stringByReplacingOccurrencesOfString:@"'" withString:kSQLShortMarks];
        }
        if ([str rangeOfString:@"\""].location != NSNotFound) {
            str =[str stringByReplacingOccurrencesOfString:@"\"" withString:kSQLDoubleMarks];
        }
        return str;
         */
    }
    
    return @"";
}

-(id)toObjectWithJSONString:(NSString *)json{
//    NSString *jsonStr = json;
//    if ([jsonStr rangeOfString:kSQLShortMarks].location != NSNotFound) {
//        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:kSQLShortMarks withString:@"'"];
//    }
//    if ([jsonStr rangeOfString:kSQLDoubleMarks].location != NSNotFound) {
//        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:kSQLDoubleMarks withString:@"\""];
//    }
    NSString *jsonStr = [self stringToOBJFilter:json];
    NSData *dt = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:dt options:NSJSONReadingMutableContainers error:nil];
    
}

-(id)stringToSQLFilter:(id)str{
    if (!isNullD(str) && [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSTRShortMarks withString:kSQLShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSTRDoubleMarks withString:kSQLDoubleMarks];
        return temp;
    }
    return str;
}

-(id)stringToOBJFilter:(id)str{
    if (!isNullD(str) && [str respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        id temp = str;
        temp = [temp stringByReplacingOccurrencesOfString:kSQLShortMarks withString:kSTRShortMarks];
        temp = [temp stringByReplacingOccurrencesOfString:kSQLDoubleMarks withString:kSTRDoubleMarks];
        return temp;
    }
    return str;
}

-(NSString *)primaryKeyWithClass:(Class)tClass{
    if (!tClass) {
        return nil;
    }
    NSDictionary *dic = [self.classDictionary objectForKey:NSStringFromClass(tClass)];
    if (!dic) {
        [self propertyProcessWithClass:tClass];
        dic = [self.classDictionary objectForKey:NSStringFromClass(tClass)];
    }
    
    for (DBAccessPropertyModel *model in [dic allValues]) {
        if (model.isPrimaryKey) {
            return model.name;
        }
    }
    
    return nil;
}

-(NSString *)primaryValueWith:(id)obj{
    NSString *pKey = [self primaryKeyWithClass:[obj class]];
    if (pKey) {
        return [obj valueForKey:pKey];
    }
    return nil;
}

-(BOOL)hasPrimaryKeyValue:(id)obj{
    Class tClass = [obj class];
    NSString *pKey = [self primaryKeyWithClass:tClass];
    if (!pKey || ![obj valueForKey:pKey]) {
        @throw [NSException exceptionWithName:@"error" reason:[NSString stringWithFormat:@"Primary Key-Value must not nil,OBJ:%@---key:%@",obj,pKey] userInfo:nil];
        return NO;
    }
    return YES;
}

-(BOOL)canConvertToClass:(NSString *)entityName{
    Class tClass = NSClassFromString(entityName);
    if (!tClass) {
        @throw [NSException exceptionWithName:@"Class error" reason:[NSString stringWithFormat:@"Class not find :[%@]",entityName] userInfo:nil];
        return NO;
    }
    return YES;
}

-(NSArray *)cascadePropertyWith:(NSString *)entityName{
    if (!entityName) {
        return nil;
    }
    NSDictionary *dic = [self.classDictionary objectForKey:entityName];
    if (!dic) {
        [self propertyProcessWithClass:NSClassFromString(entityName)];
        dic = [self.classDictionary objectForKey:entityName];
    }
    if (!dic) {
        return nil;
    }
    
    NSMutableArray *arrs = [[NSMutableArray alloc]initWithCapacity:2];
    for (DBAccessPropertyModel *model in [dic allValues]) {
        if (model.isCascadeAll || model.isCascadeSaveOrUpdate) {
            [arrs addObject:model];
        }
    }
    
    return arrs;
}

-(NSString *)dbFieldTypeNameWithType:(DBFieldType)dfType{
    NSString *dtypeName = @"TEXT";
    switch (dfType) {
        case DBFieldTypeBigint:{
            dtypeName = @"BIGINT";
        }break;
        case DBFieldTypeBool:{
            dtypeName = @"SMALLINT";
        }break;
        case DBFieldTypeDouble:{
            dtypeName = @"DOUBLE";
        }break;
        case DBFieldTypeFloat:{
            dtypeName = @"FLOAT";
        }break;
        case DBFieldTypeInteger:{
            dtypeName = @"INTEGER";
        }break;
        case DBFieldTypeSmallint:{
            dtypeName = @"SMALLINT";
        }break;
        case DBFieldTypeText:{
            dtypeName = @"TEXT";
        }break;
        default:
            break;
    }
    return dtypeName;
}

-(NSString *)propertyProcessWithClass:(Class)tClass{
    
    /////////////
    NSString *pKey = @"";
    if ([self.classDictionary objectForKey:NSStringFromClass(tClass)]) {
        return pKey;
    }
    
    Class class = tClass;
    NSScanner* scanner = nil;
    NSString* propertyType = nil;
    id clsObj = [class new];
    NSDictionary *propTypes = nil;
    if ([clsObj respondsToSelector:@selector(columnDataType)]) {
        propTypes = [clsObj columnDataType];
    }
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    NSMutableDictionary* propertyDic = [NSMutableDictionary dictionaryWithCapacity:propertyCount];
    //        NSString *pKey = @"";
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        
        DBAccessPropertyModel * model = [[DBAccessPropertyModel alloc]init];
        
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        model.name = [NSString stringWithUTF8String:propertyName];
        model.protocol = @"CascadeNone";
        
        const char *attrs = property_getAttributes(property);
        scanner = [NSScanner scannerWithString:
                   [NSString stringWithUTF8String:attrs]
                   ];
        
        [scanner scanUpToString:@"T" intoString: nil];
        [scanner scanString:@"T" intoString:nil];
        
        if ([scanner scanString:@"@\"" intoString: &propertyType]) {
            
            [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                intoString:&propertyType];
            
            model.ocFieldTypeName = propertyType;
            
            model.isMutable = [propertyType rangeOfString:@"Mutable"].location != NSNotFound;
            
            /******************/
            switch ([self.kOCTypeList indexOfObject:model.ocFieldTypeName]) {
                case 0:{
                    model.ocFieldType = OCFieldTypeString;
                    model.dbFieldType = DBFieldTypeText;
                    model.dbFieldTypeName = @"TEXT";
                }break;
                case 1:
                case 2:{
                    model.ocFieldType = OCFieldTypeArray;
                    model.dbFieldType = DBFieldTypeText;
                    model.dbFieldTypeName = @"TEXT";
                }break;
                case 3:
                case 4:{
                    model.ocFieldType = OCFieldTypeDictionary;
                    model.dbFieldType = DBFieldTypeText;
                    model.dbFieldTypeName = @"TEXT";
                }break;
                case 5:{
                    model.ocFieldType = OCFieldTypeNumber;
                    model.dbFieldType = DBFieldTypeDouble;
                    model.dbFieldTypeName = @"DOUBLE";
                }break;
                default:{
                    //OC实例有，级联操作的对象
                    model.ocFieldType = OCFieldTypeCustomer;
                }break;
            }
            
            NSMutableString *protocol = [NSMutableString string];
            //read property protocols
            while ([scanner scanString:@"<" intoString:NULL]) {
                NSString* protocolName = nil;
                [scanner scanUpToString:@">" intoString: &protocolName];
                [protocol appendString:protocolName];
                [scanner scanString:@">" intoString:NULL];
            }
            
            if (protocol.length > 0) {
                if ([protocol rangeOfString:@"Transient"].location != NSNotFound) {
                    model.protocol = @"Transient";
                    model.isTransient = YES;
                } else if([protocol rangeOfString:@"PrimaryKey"].location != NSNotFound){
                    model.protocol = @"PrimaryKey";
                    model.isPrimaryKey = YES;
                    pKey = model.name;
                } else if (model.ocFieldType == OCFieldTypeCustomer) {
                    if ([protocol rangeOfString:@"CascadeAll"].location != NSNotFound){
                        model.protocol = @"CascadeAll";
                        model.isCascadeAll = YES;
                    }else  if([protocol rangeOfString:@"CascadeSaveOrUpdate"].location != NSNotFound){
                        model.protocol = @"CascadeSaveOrUpdate";
                        model.isCascadeSaveOrUpdate = YES;
                        
                    }
                }
                if ([model.protocol isEqualToString:@"CascadeAll"]||[model.protocol isEqualToString:@"CascadeSaveOrUpdate"]) {
                    //级联关系的外键
                    model.dbFieldType = DBFieldTypeInteger;
                    model.dbFieldTypeName = @"INTEGER";
                    NSString *refKey = [self propertyProcessWithClass:NSClassFromString(model.ocFieldTypeName)];
                    model.refKeyName = refKey;
                }
            }
            /**************/
            
            if (propTypes && [propTypes objectForKey:model.name]) {
                DBAccessPropertyModel *tempModel = [propTypes objectForKey:model.name];
                model.dbFieldType = tempModel.dbFieldType;
                model.dbFieldTypeName = [self dbFieldTypeNameWithType:model.dbFieldType];
            }
            
        } else if ([scanner scanString:@"{" intoString: &propertyType]) {
            //结构体structure属性
            [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                intoString:&propertyType];
            
        } else {
            //基本类型属性
            
            [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                    intoString:&propertyType];
            
            switch ([propertyType characterAtIndex:0]) {
                case 'i':{
                    model.ocFieldType = OCFieldTypeInteger;
                    model.ocFieldTypeName = @"NSInteger";
                    model.dbFieldType = DBFieldTypeInteger;
                    model.dbFieldTypeName = @"INTEGER";
                }break;
                case 'f':{
                    model.ocFieldType = OCFieldTypeFloat;
                    model.ocFieldTypeName = @"CGFloat";
                    model.dbFieldType = DBFieldTypeFloat;
                    model.dbFieldTypeName = @"FLOAT";
                }break;
                case 'd':{
                    model.ocFieldType = OCFieldTypeDouble;
                    model.ocFieldTypeName = @"double";
                    model.dbFieldType = DBFieldTypeDouble;
                    model.dbFieldTypeName = @"DOUBLE";
                }break;
                case 's':{
                    model.ocFieldType = OCFieldTypeShort;
                    model.ocFieldTypeName = @"short";
                    model.dbFieldType = DBFieldTypeSmallint;
                    model.dbFieldTypeName = @"SMALLINT";
                }break;
                case 'Q':
                case 'q':
                case 'l':{
                    model.ocFieldType = OCFieldTypeLong;
                    model.ocFieldTypeName = @"long";
                    model.dbFieldType = DBFieldTypeBigint;
                    model.dbFieldTypeName = @"BIGINT";
                }break;
                case 'c'://32-bit下，BOOL被定义为signed char，@encode(BOOL)的结果是'c'
                case 'B':{//64-bit下，BOOL被定义为bool，@encode(BOOL)结果是'B'
                    model.ocFieldType = OCFieldTypeBool;
                    model.ocFieldTypeName = @"BOOL";
                    model.dbFieldType = DBFieldTypeSmallint;
                    model.dbFieldTypeName = @"SMALLINT";
                }break;
                default:{
                    DBAccessLog(@"无法确认的类型#####pName:%s__pType:%@",propertyName,propertyType);
                    @throw [NSException exceptionWithName:@"类型错误" reason:[NSString stringWithFormat:@"无法确认的类型#####pName:%s__pType:%@",propertyName,propertyType] userInfo:nil];
                }
                    break;
            }
            if (propTypes && [propTypes objectForKey:model.name]) {
                DBAccessPropertyModel *tempModel = [propTypes objectForKey:model.name];
                model.dbFieldType = tempModel.dbFieldType;
                model.dbFieldTypeName = [self dbFieldTypeNameWithType:model.dbFieldType];
            }
            
        }
        
        [propertyDic setValue:model forKey:model.name];
    }
    
    free(properties);
    [self.classDictionary setObject:propertyDic forKey:NSStringFromClass(tClass)];
    return pKey;
    
}

#pragma -mark entity crud
-(DBAccessResult *)makeSaveEntity:(id)objc{
    [self propertyProcessWithClass:[objc class]];
    
    NSString *pv = [self primaryValueWith:objc];
    if (!isNullD(pv)) {
        DBAccessResult *rst = [[DBAccessResult alloc]init];
        rst.resultType = DBAccessResultTypeOK;
        rst.rowId = pv.integerValue;
        DBAccessLog(@"warning!!!!!primary value::%@ already exist before save.obj::%@",pv,objc);
        return rst;
    }
    
    NSString *tName = NSStringFromClass([objc class]);
    NSDictionary *tproperties = [self.classDictionary objectForKey:tName];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO %@ (",tName];
    NSMutableString *sql2 = [NSMutableString stringWithFormat:@") VALUES ("];
    for (NSString *key in [tproperties allKeys]) {
        id obj = [tproperties objectForKey:key];
        DBAccessPropertyModel *model = (DBAccessPropertyModel *)obj;
        if (!model.isTransient && !model.isPrimaryKey) {
            id kv = [objc valueForKey:key];
            [sql appendFormat:@"%@ ,",key];
            if ((model.isCascadeSaveOrUpdate || model.isCascadeAll) && !isNullD(kv)) {
//                if (isNullD(kv)) {
//                    kv = [NSClassFromString(model.ocFieldTypeName) new];
//                }
                NSString *pvalue = [self primaryValueWith:kv];
                if (pvalue.length > 0) {
                    [sql2 appendFormat:@"\"%@\" ,",pvalue];
                }else{
                    DBAccessResult *rst = [self makeSaveEntity:kv];
                    if (rst.resultType != DBAccessResultTypeOK) {
                        return rst;
                    }
                    int64_t rowId = rst.rowId;
                    [sql2 appendFormat:@"\"%lld\" ,",rowId];
                }
            }else{
                if (model.ocFieldType == OCFieldTypeArray) {
                    if (kv) {
                        kv = [self toJSONStringWithObject:kv];
//                        if ([kv rangeOfString:@"'"].location != NSNotFound) {
//                            kv = [kv stringByReplacingOccurrencesOfString:@"'" withString:@"\'"];
//                        }
//                        if ([kv rangeOfString:@"\""].location != NSNotFound) {
//                            kv = [kv stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//                        }
                    }
                }else if (model.ocFieldType == OCFieldTypeDictionary){
                    if (kv) {
                        kv = [self toJSONStringWithObject:kv];
//                        if ([kv rangeOfString:@"'"].location != NSNotFound) {
//                            kv = [kv stringByReplacingOccurrencesOfString:@"'" withString:@"\'"];
//                        }
//                        if ([kv rangeOfString:@"\""].location != NSNotFound) {
//                            kv = [kv stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//                        }
                    }
                }else if(model.ocFieldType == OCFieldTypeString){
                    //filter
                    kv = [self stringToSQLFilter:kv];
                }
                
                if (isNullD(kv)) {
                    kv = @"";
                }
                [sql2 appendFormat:@"\"%@\" ,",kv];
            }
        }
    }

    [sql deleteCharactersInRange:NSMakeRange(sql.length-1, 1)];
    [sql2 deleteCharactersInRange:NSMakeRange(sql2.length-1, 1)];
    [sql appendFormat:@"%@);",sql2];

    DBAccessResult *result = [self execute:sql withType:DBExecuteTypeInsert];
    if (result.resultType == DBAccessResultTypeOK) {
        [objc setValue:[NSString stringWithFormat:@"%lld",result.rowId] forKey:[self primaryKeyWithClass:[objc class]]];
        result.object = objc;
    }
    return result;
}

-(id)makeFindEntity:(Class )tClass withDBRestriction:(DBRestriction *)restriction{
    NSString *alias = [NSStringFromClass(tClass) lowercaseString];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT * FROM %@ as %@",NSStringFromClass(tClass),alias];
    [self propertyProcessWithClass:tClass];
    if (restriction) {
        [sql appendString:[restriction makeRestrictionWithAlias:alias]];
    }
    NSMutableArray *objcArr = [self executeQuery:sql intoObjClass:tClass];
    return objcArr;
}

-(DBAccessResult *)makeUpdateEntity:(id)obj oldEntity:(id)old{
    Class tClass = [obj class];
    if (!tClass) {
        @throw [NSException exceptionWithName:@"Class error" reason:[NSString stringWithFormat:@"Class not find :[%@]",obj] userInfo:nil];
        return nil;
    }
    
    if ([obj isKindOfClass:[NSString class]] || [old isKindOfClass:[NSString class]]) {
        @throw [NSException exceptionWithName:@"Class error" reason:[NSString stringWithFormat:@"Class must be a customer object :[%@__%@]",obj,old] userInfo:nil];
        return nil;
    }
    [self propertyProcessWithClass:[obj class]];
    NSString *tName = NSStringFromClass(tClass);
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET " , tName];
    NSDictionary *props = [self.classDictionary objectForKey:tName];
    NSString *pKeyName,*pKeyValue;
    for (DBAccessPropertyModel *model in [props allValues]) {
        if (model.isPrimaryKey) {
            pKeyName = model.name;
            pKeyValue = [obj valueForKey:model.name];
            continue;
        }
        if (model.isTransient) {
            continue ;
        }
        id ov = [obj valueForKey:model.name];
        
        // && [self hasPrimaryKeyValue:ov]
        if ((model.isCascadeAll || model.isCascadeSaveOrUpdate)) {
            DBAccessResult *temprst = nil;
            id oldOv = [old valueForKey:model.name];
            if (isNullD(ov) && isNullD(oldOv)) {
                //do nothing
            }else if (isNullD(ov) && !isNullD(oldOv)){
                //do del
                [obj setValue:[NSNull null] forKey:model.name];
                ov = @"";
                if (model.isCascadeAll) {
                    temprst = [self makeDeleteEntity:oldOv];
                }
            }else if (!isNullD(ov) && isNullD(oldOv)){
                if (![ov isKindOfClass:[NSString class]]) {
                    NSString *pv = [self primaryValueWith:ov];
                    if (isNullD(pv)) {
                        //do insert
                        temprst = [self makeSaveEntity:ov];
                        if (temprst.resultType == DBAccessResultTypeOK) {
                            NSString *refVal=[NSString stringWithFormat:@"%lld",temprst.rowId];
                            [obj setValue:refVal forKey:model.name];
                            ov = refVal;
                        }
                    }else{
                        //maybe 级联更新，更新ov自身
                        ov = pv;
                    }
                }else{
                    @throw [NSException exceptionWithName:@"cascade object error" reason:@"cascade object must not NSString" userInfo:nil];
                }
                
            }else if (!isNullD(ov) && !isNullD(oldOv)){
                if (![ov isKindOfClass:[NSString class]] && ![oldOv isKindOfClass:[NSString class]]) {
                    //do up
                    id orgv = ov;
                    NSString *pv = [self primaryValueWith:ov];
                    if (isNullD(pv)) {
                        temprst = [self makeSaveEntity:ov];
                        if (temprst.resultType == DBAccessResultTypeOK) {
                            NSString *refVal=[NSString stringWithFormat:@"%lld",temprst.rowId];
                            [obj setValue:refVal forKey:model.name];
                            ov = refVal;
                        }
                        //如果级联删除，可以考虑删除oldOv
                    }else{
                        if ([pv isEqualToString:[self primaryValueWith:oldOv]]) {
                            temprst = [self makeUpdateEntity:orgv oldEntity:oldOv];
                        }
                        
                        ov = pv;
                    }
                }else{
                    @throw [NSException exceptionWithName:@"cascade object error" reason:@"cascade object must not NSString" userInfo:nil];
                }
                
            }
            
            if (temprst && temprst.resultType!=DBAccessResultTypeOK) {
                return temprst;
            }
            
        }
        
        ov = [self stringToSQLFilter:ov];
        if (isNullD(ov)) {
            ov = @"";
        }
        
        [sql appendFormat:@"%@ = '%@' ,",model.name,ov];
    }
    [sql deleteCharactersInRange:NSMakeRange(sql.length-1, 1)];
    DBRestriction *restriction = [[DBRestriction alloc]initWithName:pKeyName value:pKeyValue restrictionType:DBRestrictionTypeEQ];

    [sql appendString:[restriction makeRestrictionWithAlias:nil]];
    
    DBAccessResult *result = [self execute:sql withType:DBExecuteTypeUpdate];

    return result;
}

-(DBAccessResult *)makeUpdateEntity:(id)obj withDBRestriction:(DBRestriction *)restriction{
    
    Class tClass = [obj class];
    if (!tClass) {
        @throw [NSException exceptionWithName:@"Class error" reason:[NSString stringWithFormat:@"Class not find :[%@]",obj] userInfo:nil];
        return nil;
    }
    [self propertyProcessWithClass:[obj class]];
    NSString *tName = NSStringFromClass(tClass);
    
    DBAccessResult *rst = [self findEntity:tName withRestriction:restriction];
    if (rst.resultType != DBAccessResultTypeOK) {
        return rst;
    }
    
    DBAccessResult *result = [[DBAccessResult alloc]init];
    result.resultType = DBAccessResultTypeOK;
    if ([rst.object isKindOfClass:[NSArray class]]) {
        NSString *pKey = [self primaryKeyWithClass:[obj class]];
        NSArray *objs = (NSArray *)rst.object;
        for (id objc in objs) {
            [obj setValue:[self primaryValueWith:objc] forKey:pKey];
            result = [self makeUpdateEntity:obj oldEntity:objc];
            
        }
    }
    return result;

}


-(DBAccessResult *)makeDeleteEntity:(id)obj{
    
    Class tClass = [obj class];
    if (!tClass) {
        @throw [NSException exceptionWithName:@"Class error" reason:[NSString stringWithFormat:@"Class not find :[%@]",obj] userInfo:nil];
        return nil;
    }
    [self propertyProcessWithClass:[obj class]];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"DELETE FROM %@ ",NSStringFromClass(tClass)];
    if (![self hasPrimaryKeyValue:obj]) {
        DBAccessResult *result = [[DBAccessResult alloc]init];
        result.resultType = DBAccessResultTypeExcuteError;
        return result;
    }
    NSString *pKey = [self primaryKeyWithClass:tClass];
    NSString *pValue = [obj valueForKey:pKey];
    DBRestriction *rstt = [[DBRestriction alloc]initWithName:pKey value:pValue restrictionType:DBRestrictionTypeEQ];
    [sql appendString:[rstt makeRestrictionWithAlias:nil]];
    NSString *tName = NSStringFromClass(tClass);
    NSDictionary *props = [self.classDictionary objectForKey:tName];
    for (DBAccessPropertyModel *model in [props allValues]) {
        if (model.isCascadeAll) {
            id ov = [obj valueForKey:model.name];
            if (!isNullD(ov)) {
                DBAccessResult *rst = [self makeDeleteEntity:ov];
                if (rst.resultType != DBAccessResultTypeOK) {
                    DBAccessLog(@"del错误:::%@",rst.error);
                    return rst;
                }
            }else{
                DBAccessLog(@"关联的对象不存在：[name:%@]__[sql:%@]",model.name,sql);
            }
        }
    }
    
    DBAccessResult *result = [self execute:sql withType:DBExecuteTypeDelete];
    return result;
}

-(DBAccessResult *)makeDeleteEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction{
    
    DBAccessResult *rst = [self findEntity:entityName withRestriction:restriction];
    if (rst.resultType != DBAccessResultTypeOK) {
        return rst;
    }
    DBAccessResult *result = [[DBAccessResult alloc]init];
    result.resultType = DBAccessResultTypeOK;
    if ([rst.object isKindOfClass:[NSArray class]]) {
        NSArray *objs = (NSArray *)rst.object;
        for (id obj in objs) {
            result = [self deletee:obj];
            if (result.resultType != DBAccessResultTypeOK) {
                DBAccessLog(@"del error========%@__code::%d",obj,result.resultType);
                break;
            }
        }
    }
    
    return result;
}

#pragma -mark make table sql
-(NSMutableString *)makeCreateSQLWith:(NSDictionary *)tProperties className:(NSString *)tName{
    
    NSMutableString *tableSQL=[NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(",tName];
    __block BOOL hasPkey = NO;
    [tProperties enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        DBAccessPropertyModel *model = (DBAccessPropertyModel *)obj;
        
        if (!model.isTransient) {
            if (model.isPrimaryKey) {
                hasPkey = YES;
                [tableSQL appendFormat:@" %@ INTEGER PRIMARY KEY AUTOINCREMENT ,",model.name];
            }else{
                [tableSQL appendFormat:@" %@ %@ ,",model.name,model.dbFieldTypeName];
            }
            if (model.ocFieldType == OCFieldTypeCustomer) {
                NSDictionary *tproperties = [self.classDictionary objectForKey:model.ocFieldTypeName];
                NSMutableString *tsql = [self makeCreateSQLWith:tproperties className:model.ocFieldTypeName];
                [tableSQL insertString:tsql atIndex:0];
            }
        }
        
    }];
    
    [tableSQL deleteCharactersInRange:NSMakeRange(tableSQL.length-1, 1)];
    [tableSQL appendString:@");#"];

    if (!hasPkey) {
        @throw [NSException exceptionWithName:@"primary key error" reason:[NSString stringWithFormat:@"primary key not find with :[%@]",tName] userInfo:nil];
        return nil;
    }
    return tableSQL;
}

-(NSMutableString *)createTableSQLWithClass:(Class)tClass{
    
    if (!tClass) {
        return nil;
    }
    
    NSString *tName = NSStringFromClass(tClass) ;
    [self propertyProcessWithClass:tClass];
    NSDictionary *tproperties = [self.classDictionary objectForKey:tName];
    return [self makeCreateSQLWith:tproperties className:tName];

}

-(DBAccessResultType)createTablesWithNames:(NSArray *)tableNames{
    if (!tableNames) {
        DBAccessLog(@"table name must not NULL");
        return DBAccessResultTypeCreateTableError;
    }
    
    NSMutableString *sqls = [NSMutableString string];
    for (NSString *tName in tableNames) {
        if (![self canConvertToClass:tName]) {
            return DBAccessResultTypeCreateTableError;
        }
        
        if ([self tableExistWithName:tName]) {
            DBAccessLog(@"table '%@' already exist when create",tName);
            continue;
        }else{
            Class tClass =  NSClassFromString(tName);
            NSMutableString *sql = [self createTableSQLWithClass:tClass];
            if (sql.length < 1) {
                return DBAccessResultTypeCreateTableError;
            }
            [sqls appendString:sql];
        }
        
    }
    if (sqls.length > 1) {
        NSArray *sqlArr = [sqls componentsSeparatedByString:@"#"];
        for (NSString *sql in sqlArr) {
            if (sql.length > 1) {
                [self execute:sql withType:DBExecuteTypeCreate];
            }
            
        }
        
    }
    return DBAccessResultTypeOK;
}

//ALTER TABLE database_name.table_name RENAME TO new_table_name;

/*
 *  select * from sqlite_master where type = 'table' and name = 'testname';
 *  type    name    tbl_name    rootpage    sql
 *  table   testname    testname    2       ...
 */

-(BOOL)tableExistWithName:(NSString *)tname{
    //或者执行：.tables，或者.schema
    NSString *query = [NSString stringWithFormat:@"SELECT tbl_name FROM sqlite_master WHERE type = 'table' and tbl_name = '%@'",tname];
    BOOL exist = NO;
    sqlite3_stmt *stmt;
    int resultQuery = sqlite3_prepare_v2(sqlDB, [query UTF8String], -1, &stmt, nil);
    if (resultQuery == SQLITE_OK) {
//        int dcount = sqlite3_data_count(stmt);
//        int ccount = sqlite3_column_count(stmt);
        if (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char * itemp = sqlite3_column_text(stmt, 0);
            if (itemp != NULL) {
                NSString *cname = [NSString stringWithUTF8String:(const char *)itemp];
                if ([cname isEqualToString:tname]) {
                    exist = YES;
                }
            }
            
        }
        sqlite3_finalize(stmt);
    }else{
        DBAccessLog(@"db query error:%d",resultQuery);
    }
    return exist;
}

#pragma -mark impl

-(DBAccessResultType)dropTableWithName:(NSString *)tableName{
    if (!tableName) {
        return DBAccessResultTypeExcuteError;
    }
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
    DBAccessResult *result = [self execute:sql withType:DBExecuteTypeTruncate];
    
    return result.resultType;
}
-(DBAccessResultType)truncateTableWithName:(NSString *)tableName{
    if (!tableName) {
        return DBAccessResultTypeExcuteError;
    }
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    DBAccessResult *result = [self execute:sql withType:DBExecuteTypeTruncate];
//    if (result.resultType == DBAccessResultTypeOK) {
//        sql = @"VACUUM";
//        result = [self execute:sql withType:DBExecuteTypeTruncate];
//    }
    
    return result.resultType;
}

-(NSString *)indexNameWithTable:(NSString *)tableName columns:(NSArray *)cols{
    NSMutableString *idxName = [NSMutableString stringWithFormat:@"idx_%@",tableName];
    for (NSString *colName in cols) {
        [idxName appendFormat:@"_%@",colName];
    }
    return idxName;
}

-(DBAccessResultType)createIndexOnTable:(NSString *)tableName columns:(NSArray *)cols isUnique:(BOOL)unique{
    if (![self tableExistWithName:tableName] || cols.count == 0) {
        return DBAccessResultTypeCreateIndexError;
    }
    NSString *idxName = [self indexNameWithTable:tableName columns:cols];
    NSMutableString *sql = [NSMutableString stringWithString:@"CREATE"];
    if (unique) {
        [sql appendString:@" UNIQUE "];
    }
    [sql appendFormat:@" INDEX %@ on %@ (",idxName,tableName];
    for (NSString *colName in cols) {
        [sql appendFormat:@"%@ ,",colName];
    }
    [sql deleteCharactersInRange:NSMakeRange(sql.length-1, 1)];
    [sql appendString:@")"];
    
    DBAccessResult *result = [self execute:sql];
    
    return result.resultType;
}

-(DBAccessResultType)dropIndexOnTable:(NSString *)tableName columns:(NSArray *)cols{
    if (![self tableExistWithName:tableName] || cols.count == 0) {
        return DBAccessResultTypeDropIndexError;
    }
    
    NSString *idxName = [self indexNameWithTable:tableName columns:cols];
    NSString *sql = [NSString stringWithFormat:@"DROP INDEX %@",idxName];
    
    DBAccessResult *result = [self execute:sql];
    
    return result.resultType;
}

-(DBAccessResult *)save:(id)obj{
    [self beginTransaction];
    DBAccessResult *result = [self makeSaveEntity:obj];
    [self endTransactionWith:result];
    
    return result;
}
-(DBAccessResult *)saveArrs:(NSArray *)arrs{

    DBAccessResult *result = [[DBAccessResult alloc]init];
    if (arrs.count <= 0) {
        result.resultType = DBAccessResultTypeSaveError;
        return result;
    }
    NSMutableArray *objs = [[NSMutableArray alloc]initWithCapacity:arrs.count];
    [self beginTransaction];
    for (id obj in arrs) {
         result = [self makeSaveEntity:obj];
        if (result.object) {
            [objs addObject:result.object];
        }
    }
    [self endTransactionWith:result];
    result.object = objs;
    
    return result;
}
-(DBAccessResult *)findAllEntity:(NSString *)entityName{
    return [self findEntity:entityName withRestriction:nil];
}
-(DBAccessResult *)findEntity:(NSString *)entityName withRestriction:(DBRestriction *)restriction{
    DBAccessResult *result ;
    if (![self canConvertToClass:entityName]) {
        result = [[DBAccessResult alloc]init];
        result.resultType = DBAccessResultTypeExcuteError;
        return result;
    }
    Class tClass = NSClassFromString(entityName);
    [self propertyProcessWithClass:tClass];
    NSMutableArray *qrst = [self makeFindEntity:tClass withDBRestriction:restriction];
    result = [[DBAccessResult alloc]init];
    result.object = qrst;
    result.resultType = qrst?DBAccessResultTypeOK:DBAccessResultTypeExcuteError;
    return result;
}

-(DBAccessResult *)findEntity:(NSString *)entityName distinctProperty:(NSString *)propertyName withRestriction:(DBRestriction *)restriction{
    
    DBAccessResult *result = nil;
    if (![self canConvertToClass:entityName]) {
        result = [[DBAccessResult alloc]init];
        result.resultType = DBAccessResultTypeExcuteError;
        return result;
    }
    
    NSString *alias = [entityName lowercaseString];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT DISTINCT(%@) FROM %@ as %@",propertyName, entityName,alias];
    if (restriction) {
        [sql appendString:[restriction makeRestrictionWithAlias:alias]];
    }
    
    NSArray *arr = [self executeDistinct:sql];
    result = [[DBAccessResult alloc]init];
    result.resultType = (arr!=nil?DBAccessResultTypeOK:DBAccessResultTypeExcuteError);
    result.count = arr.count;
    result.object = arr;
    
    return result;
}

-(DBAccessResult *)update:(id)obj{
    
    DBAccessResult *result = [[DBAccessResult alloc]init];
    result.resultType = DBAccessResultTypeExcuteError;
    if (![self hasPrimaryKeyValue:obj]) {
        return result;
    }
    NSString *pKey = [self primaryKeyWithClass:[obj class]];
    id pval = [self primaryValueWith:obj];
    DBRestriction *rsest = [[DBRestriction alloc]initWithName:pKey value:pval restrictionType:DBRestrictionTypeEQ];
    DBAccessResult *rst = [self findEntity:NSStringFromClass([obj class]) withRestriction:rsest];
    if (rst.resultType != DBAccessResultTypeOK) {
        return  rst;
    }
    
    if ([rst.object isKindOfClass:[NSArray class]]) {
        NSArray *farr = (NSArray *)rst.object;
        if (farr.count == 1) {
            id fobj = [farr objectAtIndex:0];
            [self beginTransaction];
            result = [self makeUpdateEntity:obj oldEntity:fobj];
            [self endTransactionWith:result];
        }
    }
    
    
    return result;
}
-(DBAccessResult *)updateEntity:(id)obj withDBRestriction:(DBRestriction *)restriction;{
    
    DBAccessResult *result = nil;
    
    [self beginTransaction];
    result = [self makeUpdateEntity:obj withDBRestriction:restriction];
    [self endTransactionWith:result];
    
    return result;
}

-(DBAccessResult *)deletee:(id)obj{
    [self beginTransaction];
    DBAccessResult *tstt = [self makeDeleteEntity:obj];
    [self endTransactionWith:tstt];
    return tstt;
}
-(DBAccessResult *)deleteEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction{
    
    DBAccessResult *result ;
    if (![self canConvertToClass:entityName]) {
        result = [[DBAccessResult alloc]init];
        result.resultType = DBAccessResultTypeExcuteError;
        return result;
    }

    [self beginTransaction];
    result = [self makeDeleteEntity:entityName withDBRestriction:restriction];
    [self endTransactionWith:result];
    return result;
}

-(DBAccessResult *)countEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction{
    DBAccessResult *result = nil;
    if (![self canConvertToClass:entityName]) {
        result = [[DBAccessResult alloc]init];
        result.resultType = DBAccessResultTypeExcuteError;
        return result;
    }
    
    NSString *alias = [entityName lowercaseString];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT COUNT(*) FROM %@ as %@",entityName,alias];
    if (restriction) {
        [sql appendString:[restriction makeRestrictionWithAlias:alias]];
    }
    
    sqlite3_int64 count = [self executeCount:sql];
    result = [[DBAccessResult alloc]init];
    result.resultType = (count!=-1?DBAccessResultTypeOK:DBAccessResultTypeExcuteError);
    result.count = count;
    
    return result;
}

-(NSArray *)columnsInTable:(NSString *)tableName{
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM '%@' LIMIT 1 OFFSET 0 ",tableName];
    sqlite3_stmt *stmt;
    int resultQuery = sqlite3_prepare_v2(sqlDB, [query UTF8String], -1, &stmt, nil);
    if (resultQuery == SQLITE_OK) {
        int ccount = sqlite3_column_count(stmt);
        NSMutableArray *colmuns = [[NSMutableArray alloc]initWithCapacity:3];
        for (int i=0; i<ccount; i++) {
            const char *temp = sqlite3_column_name(stmt, i);
            if (temp != NULL) {
                NSString *colName = [NSString stringWithUTF8String:temp];
                [colmuns addObject:colName];
            }
        }
        return colmuns;
    }else{
        DBAccessLog(@"query table [%@] struct error:%d",tableName,resultQuery);
        return nil;
    }
    
}
//表结构升级时，需要增加表的字段,由于沙盒已经建立的表中没有该字段，所以需要add一个column
-(BOOL)addColumnFromTable:(NSString *)tableName columnName:(NSString *)columnName columnTypeName:(NSString *)columnTypeName
{
    BOOL columnExists = NO;
    
    sqlite3_stmt *statement;
    NSString *sqlString=[NSString stringWithFormat:@"select %@ from %@",columnName,tableName];
    const char *sqlStatement = [sqlString UTF8String];
    if(sqlite3_prepare_v2(sqlDB, sqlStatement, -1, &statement, NULL) == SQLITE_OK){
        columnExists = YES;
        
    }else{
        
        NSString *updateSQL = [NSString stringWithFormat: @"ALTER TABLE %@ ADD COLUMN %@ %@",tableName,columnName,columnTypeName];
        const char *update_stmt = [updateSQL UTF8String];
        sqlite3_prepare_v2(sqlDB, update_stmt, -1, &statement, NULL);
        
        if(sqlite3_step(statement)==SQLITE_DONE)
        {
            columnExists = YES;
            
            
        }
        
    }
    
    return columnExists;
}

#pragma -mark exec sql

-(void)beginTransaction{
    char *err;
    sqlite3_exec(sqlDB, "begin transaction",0 ,0 ,&err);
    
}
-(void)endTransactionWith:(DBAccessResult *)result{
    int ret ;
    char *err;
    if (result && result.resultType == DBAccessResultTypeOK) {
        ret = sqlite3_exec(sqlDB, "commit transaction" , 0 ,0 , &err);
    }else{
        ret = sqlite3_exec(sqlDB, "rollback transaction", 0, 0 , &err);
    }
}

int __setupBusyHandler(void *dbc,int recount){
    if (recount > retryBusyCount) {
        DBAccessLog(@"_______db busy , recount:%d",recount);
//        sqlite3_busy_handler((sqlite3 *)dbc, NULL, NULL);
        return 0;
    }
    return 1;
}


-(NSArray *)executeDistinct:(NSString *)sql{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    sqlite3_stmt *statement;
    int rst = sqlite3_prepare_v2(sqlDB, [sql UTF8String], -1, &statement, NULL);
    if (rst == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *itext = sqlite3_column_text(statement, 0);
            if (itext != NULL) {
                NSString *sv = [NSString stringWithUTF8String:(const char *)itext];
                if (sv.length > 0) {
                    [arr addObject:sv];
                }
            }
        }
    }else{
        DBAccessLog(@"execute distinct sql error::[%d]___sql-->%@",rst,sql);
        arr = nil;
    }
    sqlite3_finalize(statement);
    return arr;
}

-(sqlite_int64)executeCount:(NSString *)sql{
    sqlite_int64 count = 0;
    sqlite3_stmt *statement;
    int rst = sqlite3_prepare_v2(sqlDB, [sql UTF8String], -1, &statement, NULL);
    if (rst == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            count = sqlite3_column_int64(statement, 0);
        }
    }else{
        DBAccessLog(@"execute count sql error::[%d]___sql-->%@",rst,sql);
        count = -1;
    }
    sqlite3_finalize(statement);
    return count;
}

-(DBAccessResult *)execute:(NSString *)sql{
    DBAccessResult *result = [[DBAccessResult alloc]init];
    result.resultType = DBAccessResultTypeExcuteError;
    if (sql.length < 1) {
        return result;
    }
    
    char *err;
    int rst = sqlite3_exec(sqlDB, [sql UTF8String], NULL, NULL, &err);
    
    if (rst == SQLITE_OK) {
        result.resultType = DBAccessResultTypeOK;
    }else{
        result.error = [NSError errorWithDomain:[NSString stringWithFormat:@"sql exec error::%@",sql] code:rst userInfo:nil];
        DBAccessLog(@"执行sql失败errno::%d  sql::%@",rst,sql);
    }
    
    return result;
    
}
//Create,Insert,Delete
-(DBAccessResult *)execute:(NSString *)sql withType:(DBExecuteType)type{
    sqlite_int64 rowId  = -1;
    DBAccessResult *result = [self execute:sql];
    if (result.resultType==DBAccessResultTypeOK ) {
        if (type == DBExecuteTypeInsert) {
            rowId = sqlite3_last_insert_rowid(sqlDB);
            result.rowId = rowId;
            //影响行数：sqlite3_changes(sqlDB)
        }
    }
    
    return result;
}

-(NSMutableArray *)executeQuery:(NSString *)sql intoObjClass:(Class)tClass{

    NSMutableArray *objArr = nil;
    sqlite3_stmt *statement;
    int rst = sqlite3_prepare_v2(sqlDB, [sql UTF8String], -1, &statement, NULL);
    if (rst == SQLITE_OK) {
        int dcolumn =sqlite3_column_count(statement);
//        int dcount = sqlite3_data_count(statement);
        objArr = [NSMutableArray arrayWithCapacity:10];
        id modelObj = [self.classDictionary objectForKey:NSStringFromClass(tClass)];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            id entity = [tClass new];
            for (int i=0; i<dcolumn; i++) {
                const char *colName = sqlite3_column_name(statement, i);
                if (colName == NULL) {
                    continue;
                }
                NSString *cName = [NSString stringWithUTF8String:colName];
                DBAccessPropertyModel *p = [modelObj objectForKey:cName];
                if (isNullD(p)) {
                    DBAccessLog(@"column [%@] not find in class [%@]",cName,tClass);
                    continue ;
                }
                if (p.isCascadeAll || p.isCascadeSaveOrUpdate) {
                    NSString *refValue = @"";
                    const unsigned char *itext = sqlite3_column_text(statement, i);
                    if (itext != NULL) {
                        refValue = [NSString stringWithUTF8String:(const char *)itext];
                    }
                    if (refValue.length > 0) {
                        DBRestriction *rstion = [[DBRestriction alloc]initWithName:p.refKeyName value:refValue restrictionType:DBRestrictionTypeEQ];
                        NSMutableArray *refArrs = [self makeFindEntity:NSClassFromString(p.ocFieldTypeName) withDBRestriction:rstion];

                        if (refArrs.count == 1) {
                            [entity setValue:[refArrs objectAtIndex:0] forKey:cName];
                        }
                    }
                    continue;
                }
                switch (p.ocFieldType) {
                    case OCFieldTypeArray:{
                        const unsigned char *itemp = sqlite3_column_text(statement, i);
                        if (itemp != NULL) {
                            NSString *json = [NSString stringWithUTF8String:(const char *)itemp];
                            id obj = [self toObjectWithJSONString:json];
                            if (obj && [obj isKindOfClass:[NSArray class]]) {
                                [entity setValue:obj forKey:cName];
                            }
                            
                        }
                    }break;
                    case OCFieldTypeBool:{
                        [entity setValue:[NSNumber numberWithBool:sqlite3_column_int(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeCustomer:{
                        
                    }break;
                    case OCFieldTypeDictionary:{
                        const unsigned char *itemp = sqlite3_column_text(statement, i);
                        if (itemp != NULL) {
                            NSString *json = [NSString stringWithUTF8String:(const char *)itemp];
                            id obj = [self toObjectWithJSONString:json];
                            if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                                [entity setValue:obj forKey:cName];
                            }
                            
                        }
                    }break;
                    case OCFieldTypeDouble:{
                        [entity setValue:[NSNumber numberWithDouble:sqlite3_column_double(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeFloat:{
                        [entity setValue:[NSNumber numberWithFloat:sqlite3_column_double(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeInteger:{
                        [entity setValue:[NSNumber numberWithInt:sqlite3_column_int(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeLong:{
                        [entity setValue:[NSNumber numberWithLong:sqlite3_column_double(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeNumber:{
                        [entity setValue:[NSNumber numberWithDouble:sqlite3_column_double(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeShort:{
                        [entity setValue:[NSNumber numberWithShort:sqlite3_column_int(statement, i)] forKey:cName];
                    }break;
                    case OCFieldTypeString:{
                        
                    }
                    default:{
                        const unsigned char *itemp = sqlite3_column_text(statement, i);
                        if (itemp != NULL) {
                            NSString *strValue = [NSString stringWithUTF8String:(const char *)itemp];
                            strValue = [self stringToOBJFilter:strValue];
                            [entity setValue:strValue forKey:cName];
                        }
                    }break;
                }
                
            }
            [objArr addObject:entity];
        }
        
    }else{
        DBAccessLog(@"失败sql::%@ __code:%d",sql,rst);
    }
    sqlite3_finalize(statement);
    return objArr;
}


@end

@implementation DBAccessPropertyModel

//

@end

@implementation DBAccessResult

//

@end


