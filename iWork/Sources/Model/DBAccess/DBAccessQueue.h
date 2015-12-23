//
//  DBAccessQueue.h
//  DBDemo
//
//  Created by adele on 14-10-12.
//  Copyright (c) 2014年 fromtime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBAccess.h"


@interface DBAccessQueue : NSObject

@property(nonatomic)BOOL disableAutoConnect;
@property(nonatomic)int busyRetryCount;
@property(nonatomic)int busyTimeout;

-(DBAccessQueue *)initWithPath:(NSString *)path;
-(DBAccessResultType)openDBQueue;
-(DBAccessResultType)openDBReadOnlyQueue;
-(DBAccessResultType)closeDBQueue;

-(void)save:(id)obj finished:(void (^)(DBAccessResult *result))block;
-(void)saveArrs:(NSArray *)arrs finished:(void (^)(DBAccessResult *result))block;

-(void)update:(id)obj finished:(void (^)(DBAccessResult *result))block;
-(void)updateEntity:(id)obj withDBRestriction:(DBRestriction *)restriction finished:(void (^)(DBAccessResult *result))block;

-(void)deletee:(id)obj finished:(void (^)(DBAccessResult *result))block;
-(void)deleteEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction finished:(void (^)(DBAccessResult *result))block;

-(DBAccessResult *)findAllEntity:(NSString *)entityName;
-(DBAccessResult *)findEntity:(NSString *)entityName withRestriction:(DBRestriction *)restriction;
-(DBAccessResult *)findEntity:(NSString *)entityName distinctProperty:(NSString *)propertyName withRestriction:(DBRestriction *)restriction;

-(DBAccessResult *)countEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction;

@end
