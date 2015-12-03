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
typedef void (^RequestSuccess)(WGBaseModel *baseModel, NSError *error);
typedef void (^RequestFailed)(WGBaseModel *baseModel, NSError *error);

@interface WGBaseRequest : NSObject

@property (nonatomic, strong) NSMutableDictionary *getParams;
@property (nonatomic, strong) NSMutableDictionary *postParams;

- (NSString *)rootUrl;

- (NSString *)pathName;

- (WGHTTPRequestMethod)requestMethod;

- (void)cancel;

- (void)requestWithSuccess:(void(^)(WGBaseModel *baseModel, NSError *error))success
                   failure:(void(^)(WGBaseModel *baseModel, NSError *error))failure;

- (WGBaseModel *)responseModelWithData:(id)data;

@end
