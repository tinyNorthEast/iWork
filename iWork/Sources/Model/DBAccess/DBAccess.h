//
//  DBAccess.h
//  Test
//
//  Created by adele on 13-11-21.
//  Copyright (c) 2013年 adele. All rights reserved.
//

#ifdef DEBUG
#define DBAccessLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DBAccessLog(...)
#endif

typedef enum {
    DBAccessResultTypeOK,
    DBAccessResultTypeOpenDBError,
    DBAccessResultTypeCreateTableError,
    DBAccessResultTypeUpdateTableStruct,
    DBAccessResultTypeDeleteTableError,
    DBAccessResultTypeTruncateTableError,
    DBAccessResultTypeCreateIndexError,
    DBAccessResultTypeDropIndexError,
    DBAccessResultTypeCloseDBError,
    DBAccessResultTypeSaveError,
    DBAccessResultTypeSaveBeforeLoadError,
    DBAccessResultTypeSaveOrUpdateError,
    DBAccessResultTypeDeleteObjError,
    DBAccessResultTypeDeleteByPropertyError,
    DBAccessResultTypeExcuteError
}DBAccessResultType;


//可选字段，字段保存、更新，级联操作，事务

#import <Foundation/Foundation.h>
#import "DBRestriction.h"

@protocol Transient <NSObject>
//
@end

@protocol CascadeSaveOrUpdate <NSObject>
//
@end
//@protocol CascadeDelete <NSObject>
//
//@end
@protocol CascadeAll <NSObject>
//
@end
@protocol CascadeNone <NSObject>
//
@end
@protocol PrimaryKey <NSObject>
//这个是主键，不支持共享主键
@end

@protocol DBStructDelegate <NSObject>
@optional
-(NSDictionary *)columnDataType;
@end

/*
@protocol DBAccessEntity <NSObject>
@optional
//当前类对应的数据库表名。若不实现该方法则以class name为表名
//-(NSString *)tableName;//暂不支持自定义tableName
//当前表的主键。若不实现该方法则创建一个tkey作为表的主键，若该方法的返回值与class中的某个属性名一致则把该属性设置为主键
//-(NSString *)primaryKey;
@end
 */
/**********begin*********/
/**属性设置开放出来
 * 在DBAccessPropertyModel用于自定义某个属性在数据库的存储类型时，
 * 1、目前仅支持设置dbFieldType,
 * 2、将来用这个可以支持自定义列名
 */
typedef enum {
    DBFieldTypeInteger,
    DBFieldTypeFloat,
    DBFieldTypeDouble,
    DBFieldTypeBool,
    DBFieldTypeSmallint,
    DBFieldTypeBigint,
    DBFieldTypeText
}DBFieldType;

@interface DBAccessPropertyModel : NSObject
@property (nonatomic,copy) NSString* name;
@property (nonatomic,assign) DBFieldType dbFieldType;
@property (nonatomic,copy) NSString *dbFieldTypeName;
@end
/**********end*********/

//NSDictionary,NSArray可以转换成json string当成varchar处理

@interface DBAccessResult : NSObject
@property(nonatomic)DBAccessResultType resultType;
@property(nonatomic,strong)id object;
@property(nonatomic,assign)int64_t rowId;
@property(nonatomic,strong)NSError *error;
@property(nonatomic)int64_t count;//这个目前暂时用于统计数量
@end

@interface DBAccess : NSObject
//当申请不到数据库操作锁时重试次数和超时时间(毫秒)，这两个设置只会有一个生效，busyRetryCount优先级高
//如果需要设置需要在open数据库之前进行设置
//目前设置busyTimeout不太好使，如果需要设置的话推荐busyRetryCount
@property(nonatomic)int busyRetryCount;
@property(nonatomic)int busyTimeout;

-(DBAccess *)initWithPath:(NSString *)path;
-(DBAccessResultType)open;
-(DBAccessResultType)openReadOnly;
-(DBAccessResultType)close;

-(DBAccessResultType)createTablesWithNames:(NSArray *)tableNames;
-(DBAccessResultType)dropTableWithName:(NSString *)tableName;
-(DBAccessResultType)truncateTableWithName:(NSString *)tableName;
-(DBAccessResultType)dropIndexOnTable:(NSString *)tableName columns:(NSArray *)cols;
-(DBAccessResultType)createIndexOnTable:(NSString *)tableName columns:(NSArray *)cols isUnique:(BOOL)unique;

-(DBAccessResult *)save:(id)obj;
-(DBAccessResult *)saveArrs:(NSArray *)arrs;

-(DBAccessResult *)findAllEntity:(NSString *)entityName;
-(DBAccessResult *)findEntity:(NSString *)entityName withRestriction:(DBRestriction *)restriction;
-(DBAccessResult *)findEntity:(NSString *)entityName distinctProperty:(NSString *)propertyName withRestriction:(DBRestriction *)restriction;

//primary key value不能为空，obj的所有属性的所有值将会被更新，调用结果最多影响一条记录。
-(DBAccessResult *)update:(id)obj;
//obj的所有属性的所有值将会被更新入所有符合restriction条件的记录，调用结果会影响所有符合条件的记录
-(DBAccessResult *)updateEntity:(id)obj withDBRestriction:(DBRestriction *)restriction;

-(DBAccessResult *)deletee:(id)obj;
-(DBAccessResult *)deleteEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction;

-(DBAccessResult *)countEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction;

-(DBAccessResult *)execute:(NSString *)sql;
-(NSArray *)columnsInTable:(NSString *)tableName;
//表结构升级时，需要增加表的字段,由于沙盒已经建立的表中没有该字段，所以需要add一个column
-(BOOL)addColumnFromTable:(NSString *)tableName columnName:(NSString *)columnName columnTypeName:(NSString *)columnTypeName;

extern BOOL isNullD(id value);

@end
