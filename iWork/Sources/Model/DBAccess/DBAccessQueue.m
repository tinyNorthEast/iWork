//
//  DBAccessQueue.m
//  DBDemo
//
//  Created by adele on 14-10-12.
//  Copyright (c) 2014年 fromtime. All rights reserved.
//

#import "DBAccessQueue.h"

@interface DBAccessQueueInstance : NSObject
@property(nonatomic)dispatch_queue_t dbQueue;//strong
+(instancetype)queueInstance;
@end

@interface DBAccessQueue()
@property(nonatomic,strong)DBAccess *db;
@end

@implementation DBAccessQueue{
    
}

-(DBAccessQueue *)initWithPath:(NSString *)path{
    if (self = [super init]) {
        _db = [[DBAccess alloc]initWithPath:path];
        return self;
    }
    return nil;
}
-(DBAccessResultType)openDBQueue{
    _db.busyRetryCount = _busyRetryCount;
    _db.busyTimeout = _busyTimeout;
    return [_db open];
}
-(DBAccessResultType)openDBReadOnlyQueue{
    _db.busyRetryCount = _busyRetryCount;
    _db.busyTimeout = _busyTimeout;
    return [_db openReadOnly];
}
-(DBAccessResultType)closeDBQueue{
    return [_db close];
}

- (void)save:(id)obj finished:(void (^)(DBAccessResult *result))block{
    dispatch_async([DBAccessQueueInstance queueInstance].dbQueue, ^{
        if (!self.disableAutoConnect) {
            [self openDBQueue];
        }
        DBAccessResult *rst = [_db save:obj];
        if (!self.disableAutoConnect) {
            [self closeDBQueue];
        }
        if (block) {
            block(rst);
        }
    });
}

-(void)saveArrs:(NSArray *)arrs finished:(void (^)(DBAccessResult *result))block{
    dispatch_async([DBAccessQueueInstance queueInstance].dbQueue, ^{
        if (!self.disableAutoConnect) {
            [self openDBQueue];
        }
        DBAccessResult *rst = [_db saveArrs:arrs];
        if (!self.disableAutoConnect) {
            [self closeDBQueue];
        }
        if (block) {
            block(rst);
        }
    });
}

-(void)update:(id)obj finished:(void (^)(DBAccessResult *result))block{
    dispatch_async([DBAccessQueueInstance queueInstance].dbQueue, ^{
        if (!self.disableAutoConnect) {
            [self openDBQueue];
        }
        DBAccessResult *rst = [_db update:obj];
        if (!self.disableAutoConnect) {
            [self closeDBQueue];
        }
        if (block) {
            block(rst);
        }
    });
}
-(void)updateEntity:(id)obj withDBRestriction:(DBRestriction *)restriction finished:(void (^)(DBAccessResult *result))block{
    dispatch_async([DBAccessQueueInstance queueInstance].dbQueue, ^{
        if (!self.disableAutoConnect) {
            [self openDBQueue];
        }
        DBAccessResult *rst = [_db updateEntity:obj withDBRestriction:restriction];
        if (!self.disableAutoConnect) {
            [self closeDBQueue];
        }
        if (block) {
            block(rst);
        }
    });
}

-(void)deletee:(id)obj finished:(void (^)(DBAccessResult *result))block{
    dispatch_async([DBAccessQueueInstance queueInstance].dbQueue, ^{
        if (!self.disableAutoConnect) {
            [self openDBQueue];
        }
        DBAccessResult *rst = [_db deletee:obj];
        if (!self.disableAutoConnect) {
            [self closeDBQueue];
        }
        if (block) {
            block(rst);
        }
    });
}
-(void)deleteEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction finished:(void (^)(DBAccessResult *result))block{
    dispatch_async([DBAccessQueueInstance queueInstance].dbQueue, ^{
        if (!self.disableAutoConnect) {
            [self openDBQueue];
        }
        DBAccessResult *rst = [_db deleteEntity:entityName withDBRestriction:restriction];
        if (!self.disableAutoConnect) {
            [self closeDBQueue];
        }
        if (block) {
            block(rst);
        }
    });
}

-(DBAccessResult *)findAllEntity:(NSString *)entityName{
    if (!self.disableAutoConnect) {
        [self openDBReadOnlyQueue];
    }
    DBAccessResult *rst = [self.db findAllEntity:entityName];
    if (!self.disableAutoConnect) {
        [self closeDBQueue];
    }
    return rst;
    
}
-(DBAccessResult *)findEntity:(NSString *)entityName withRestriction:(DBRestriction *)restriction{
    
    if (!self.disableAutoConnect) {
        [self openDBReadOnlyQueue];
    }
    DBAccessResult *rst = [self.db findEntity:entityName withRestriction:restriction];
    if (!self.disableAutoConnect) {
        [self closeDBQueue];
    }
    return rst;
}

-(DBAccessResult *)findEntity:(NSString *)entityName distinctProperty:(NSString *)propertyName withRestriction:(DBRestriction *)restriction{
    if (!self.disableAutoConnect) {
        [self openDBReadOnlyQueue];
    }
    DBAccessResult *rst = [self.db findEntity:entityName distinctProperty:propertyName withRestriction:restriction];
    if (!self.disableAutoConnect) {
        [self closeDBQueue];
    }
    return rst;
}

-(DBAccessResult *)countEntity:(NSString *)entityName withDBRestriction:(DBRestriction *)restriction{
    if (!self.disableAutoConnect) {
        [self openDBReadOnlyQueue];
    }
    DBAccessResult *rst = [self.db countEntity:entityName withDBRestriction:restriction];
    if (!self.disableAutoConnect) {
        [self closeDBQueue];
    }
    return rst;
}

@end

@implementation DBAccessQueueInstance

+(instancetype)queueInstance{
    static DBAccessQueueInstance *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DBAccessQueueInstance alloc]init];
        instance.dbQueue = dispatch_queue_create("com.adele.q.dbq", DISPATCH_QUEUE_SERIAL);
    });
    return instance;
}

@end