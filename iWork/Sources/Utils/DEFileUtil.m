//
//  DEFileUtil.m
//  DiEnterprise
//
//  Created by adele on 15/5/27.
//  Copyright (c) 2015年 adele. All rights reserved.
//

#import "DEFileUtil.h"

#import "WGValidJudge.h"
#import "WGBaseModel.h"
#import "WGBaseRequest.h"

#import "WGGlobal.h"

@implementation DEFileUtil

#pragma mark - Class method

+ (NSString *)requestProfileDirectory
{
    NSString *directory = [DEFileUtil userCacheDir];
    
    if ([WGValidJudge isValidString:directory]) {
        directory = [directory stringByAppendingPathComponent:@"RequestCache"];
        
        BOOL isDirectory = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:&isDirectory];
        
        if (!isExist || !isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return directory;
}

+ (void)cacheRequestModel:(WGBaseModel *)model requestClass:(Class)requestClass key:(NSString *)key
{
    if (!model) {
        return;
    }
    
    NSDictionary *dictionary = [model toDictionary];
    NSString *filePath = [self requestProfileDirectory];
    
    if ([WGValidJudge isValidDictionary:dictionary] && [WGValidJudge isValidString:filePath]) {
        NSMutableData *archiveData = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiveData];
        
        filePath = [NSString stringWithFormat:@"%@/%@", filePath, NSStringFromClass(requestClass)];
        if ([WGValidJudge isValidString:key]) {
            filePath = [NSString stringWithFormat:@"%@-%@", filePath, key];
        }
        
        if (!key) {
            key = @"";
        }
        [archiver encodeObject:dictionary forKey:key];
        [archiver finishEncoding];
        [archiveData writeToFile:filePath atomically:YES];
    }
}

+ (NSString *)getRequestModelCacheObjectWithRequestClass:(Class)requestClass key:(NSString *)key
{
    id jsonData = nil;
    NSString *filePath = [self requestProfileDirectory];
    
    if ([WGValidJudge isValidString:filePath]) {
        filePath = [NSString stringWithFormat:@"%@/%@", filePath, NSStringFromClass(requestClass)];
        if ([WGValidJudge isValidString:key]) {
            filePath = [NSString stringWithFormat:@"%@-%@", filePath, key];
        }
        
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        if (!data) {
            return nil;
        }
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        if (!key) {
            key = @"";
        }
        jsonData = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];
    }
    
    return jsonData;
}

+(void)createDir:(NSString *)dir{
    BOOL isdir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir isDirectory:&isdir]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

/**
 *  当前用户document根目录
 *
 *  @return <#return value description#>
 */
+(NSString *)userDocumentDir{
    if ([WGGlobal sharedInstance].phone.length > 0) {
        NSString *udc = [[DEFileUtil documentDir]stringByAppendingPathComponent:[WGGlobal sharedInstance].phone];
        [DEFileUtil createDir:udc];
        return udc;
    }
    return nil;
}
/**
 *  当前用户cache根目录
 *
 *  @return <#return value description#>
 */
+(NSString *)userCacheDir{
    if ([WGGlobal sharedInstance].phone.length > 0) {
        NSString *ucd = [[DEFileUtil cacheDir]stringByAppendingPathComponent:[WGGlobal sharedInstance].phone];
        [DEFileUtil createDir:ucd];
        return ucd;
    }
    return nil;
}

/**
 *  系统document目录
 *
 *  @return <#return value description#>
 */
+(NSString *)documentDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
}
/**
 *  系统cache目录
 *
 *  @return <#return value description#>
 */
+(NSString *)cacheDir{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
}
/**
 *   用户数据库目录
 *
 *   @return <#return value description#>
 *
 */
+(NSString *)userDBPath
{
    return [[DEFileUtil userCacheDir]stringByAppendingPathComponent:@"useresp.db"];
}

+(NSString *)logDBPath{
    return [[DEFileUtil cacheDir] stringByAppendingPathComponent:@"req_any.dat"];
}

/**
 *  db文件上传前的备份目录
 *
 *  @return <#return value description#>
 */
+(NSString *)logDBDir{
    NSString *dir = [[DEFileUtil cacheDir] stringByAppendingPathComponent:@"req_bak"];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fm fileExistsAtPath:dir isDirectory:&isDir]) {
        NSError *errrr = nil;
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&errrr];
        if (errrr) {
            return nil;
        }
    }
    return dir;
}

/**
 *  写db失败时，把错误信息保存到这个文件里
 *
 *  @return <#return value description#>
 */
+(NSString *)logErrorPath{
    NSString *path = [[DEFileUtil cacheDir] stringByAppendingPathComponent:@"save_error.dat"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

@end
