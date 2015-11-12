//
//  WGBaseRequest.h
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGBaseModel;

typedef NS_ENUM(NSUInteger, WGHTTPRequestMethod){
    WGHTTPRequestMethodGET = 0,
    WGHTTPRequestMethodPOST
};
//typedef NS_ENUM(NSUInteger, WGRequestCode) {
//    WGRequestCodeSuccuess,
//    WGRequestCodeFailure
//};
typedef void (^RequestSuccess)(WGBaseModel *model, NSURLSessionTask *task);
typedef void (^RequestFailed)(NSError *error, NSURLSessionTask *task);

@interface WGBaseRequest : NSObject

@property (nonatomic, strong) NSMutableDictionary *getParams;
@property (nonatomic, strong) NSMutableDictionary *postParams;

- (NSString *)rootUrl;

- (NSString *)pathName;

- (WGHTTPRequestMethod)requestMethod;

- (void)cancel;

- (void)requestWithSuccess:(void(^)(WGBaseModel *model, NSURLSessionTask *task))success
                   failure:(void(^)(NSError *error, NSURLSessionTask *task))failure;

- (WGBaseModel *)responseModelWithData:(id)data;

@end
