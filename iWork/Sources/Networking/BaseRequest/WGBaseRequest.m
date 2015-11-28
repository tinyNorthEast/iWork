//
//  WGBaseRequest.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

#import "AFNetworking.h"

#import "WGURLConfig.h"
#import "WGBaseModel.h"

@interface WGBaseRequest()

@property (nonatomic, copy) RequestSuccess requestSuccess;

@property (nonatomic, copy) RequestFailed requestFailed;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation WGBaseRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableDictionary *)getParams{
    if (!_getParams) {
        _getParams = [NSMutableDictionary dictionary];
    }
    return _getParams;
}

- (NSMutableDictionary *)postParams{
    if (!_postParams) {
        _postParams = [NSMutableDictionary dictionary];
    }
    return _postParams;
}

- (NSString *)rootUrl{
    return API_BASE_URL;
}

- (NSString *)pathName{
    return nil;
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}
- (AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html",@"text/plain",nil];
    }
    return _manager;
}

- (void)cancel{
    [self.task cancel];
    
    self.requestSuccess = nil;
    self.requestFailed = nil;
    self.task = nil;
}

- (void)cancelAllOperations{
    [self.manager.operationQueue cancelAllOperations];
}

- (void)requestWithSuccess:(void(^)(WGBaseModel *model, NSURLSessionTask *task))success
                   failure:(void(^)(NSError *error, NSURLSessionTask *task))failure{
    self.requestSuccess = success;
    self.requestFailed = failure;
    
    if (self.requestMethod == WGHTTPRequestMethodGET) {
        
    }else{
        
    }
    [self request];
}


- (NSString *)buildRequestUrl{
    NSString *detailUrl = [self pathName];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    NSString *requesturl = nil;
    if ([self.rootUrl hasSuffix:@"/"] ) {
        requesturl = [NSString stringWithFormat:@"%@%@", self.rootUrl, detailUrl];
    }else{
        requesturl = [NSString stringWithFormat:@"%@/%@", self.rootUrl, detailUrl];
    }
    
    return requesturl;
}
- (void)request{
    if (self.requestMethod == WGHTTPRequestMethodGET) {
        self.task = [self.manager GET:[self buildRequestUrl] parameters:self.getParams success:^(NSURLSessionDataTask *task, id responseObject) {
            WGBaseModel *model = [self responseModelWithData:responseObject];
            if (self.requestSuccess) {
                _requestSuccess(model,task);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (self.requestFailed) {
                _requestFailed(error,task);
            }
            
        }];
    }else{
        self.task = [self.manager POST:[self buildRequestUrl] parameters:self.postParams success:^(NSURLSessionDataTask *task, id responseObject) {
            WGBaseModel *model = [self responseModelWithData:responseObject];
            if (self.requestSuccess) {
                _requestSuccess(model,task);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (self.requestFailed) {
                _requestFailed(error,task);
            }
        }];
    }
    
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithData:data error:nil];
}

@end
