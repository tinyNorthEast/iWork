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
typedef void (^RequestSuccess)(WGBaseModel *model, NSError *error);
typedef void (^RequestFailed)(WGBaseModel *model, NSError *error);

@interface WGBaseRequest : NSObject

@property (nonatomic, strong) NSMutableDictionary *getParams;
@property (nonatomic, strong) NSMutableDictionary *postParams;

- (NSString *)rootUrl;

- (NSString *)pathName;

- (WGHTTPRequestMethod)requestMethod;

- (void)cancel;

- (void)requestWithSuccess:(void(^)(WGBaseModel *model, NSError *error))success
                   failure:(void(^)(WGBaseModel *model, NSError *error))failure;

- (WGBaseModel *)responseModelWithData:(id)data;

@end
