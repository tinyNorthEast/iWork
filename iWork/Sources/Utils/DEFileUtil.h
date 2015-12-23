//
//  DEFileUtil.h
//  DiEnterprise
//
//  Created by adele on 15/5/27.
//  Copyright (c) 2015年 adele. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGBaseRequest;
@class WGBaseModel;

@interface DEFileUtil : NSObject

/**
 *  缓存请求模型数据，存放位置~Library/Caches/ProtocolCache/，文件名："调用请求名称" + key
 *
 *  @param model       模型数据，不能为空
 *  @param requestClass 调用的请求类型，用于拼接缓存文件名称
 *  @param key         文件名中的关键字
 */
+ (void)cacheRequestModel:(WGBaseModel *)model requestClass:(Class)requestClass key:(NSString *)key;

/**
 *  获取缓存文件的请求模型的json数据
 *
 *  @param requestClass 调用的请求类型，用于拼接缓存文件名称
 *  @param key          文件名中的关键字，需与cacheRequestModel:requestClass:key:中的key相同
 *
 *  @return json数据
 */
+ (NSString *)getRequestModelCacheObjectWithRequestClass:(Class)requestClass key:(NSString *)key;

/**
 *  当前用户document根目录
 *
 *  @return <#return value description#>
 */
+(NSString *)userDocumentDir;
/**
 *  当前用户cache根目录
 *
 *  @return <#return value description#>
 */
+(NSString *)userCacheDir;

/**
 *  系统document目录
 *
 *  @return <#return value description#>
 */
+(NSString *)documentDir;
/**
 *  系统cache目录
 *
 *  @return <#return value description#>
 */
+(NSString *)cacheDir;
/**
 *   用户数据库目录
 *
 *   @return <#return value description#>
 *
 */
+(NSString *)userDBPath;

+(NSString *)logDBPath;

/**
 *  db文件上传前的备份目录
 *
 *  @return <#return value description#>
 */
+(NSString *)logDBDir;

/**
 *  写db失败时，把错误信息保存到这个文件里
 *
 *  @return <#return value description#>
 */
+(NSString *)logErrorPath;


@end
