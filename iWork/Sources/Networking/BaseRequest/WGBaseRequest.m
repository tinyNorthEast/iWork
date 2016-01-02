//
//  WGBaseRequest.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

#import "AFNetworking.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGGlobal.h"

#import "WGURLConfig.h"
#import "WGBaseModel.h"

@interface WGBaseRequest()

@property (nonatomic, copy) RequestSuccess requestSuccess;

@property (nonatomic, copy) RequestFailed requestFailed;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;


@end

@implementation WGBaseRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setBaseParamsTo:(NSMutableDictionary *)param{
    [param safeSetValue:@"2" forKey:@"client"];
    [param safeSetValue:[[WGGlobal sharedInstance] deviceToken] forKey:@"eq_num"];
    [param safeSetValue:@"1.0" forKey:@"version"];
}

- (NSMutableDictionary *)getParams{
    if (!_getParams) {
        _getParams = [NSMutableDictionary dictionary];
        [self setBaseParamsTo:_getParams];
    }
    return _getParams;
}

- (NSMutableDictionary *)postParams{
    if (!_postParams) {
        _postParams = [NSMutableDictionary dictionary];
        [self setBaseParamsTo:_postParams];
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
- (AFHTTPRequestOperationManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    }
    return _manager;
}

- (void)cancel{
    [self.manager.operationQueue cancelAllOperations];
    
    self.requestSuccess = nil;
    self.requestFailed = nil;
}

- (void)cancelAllOperations{
    [self.manager.operationQueue cancelAllOperations];
}

- (void)requestWithSuccess:(void(^)(WGBaseModel *baseModel, NSError *error))success
                   failure:(void(^)(WGBaseModel *baseModel, NSError *error))failure{
    self.requestSuccess = success;
    self.requestFailed = failure;
    
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
       [self.manager GET:[self buildRequestUrl] parameters:self.getParams success:^(AFHTTPRequestOperation *operation, id responseObject)  {
            WGBaseModel *model = [self responseModelWithData:responseObject];
            if (self.requestSuccess) {
                _requestSuccess(model,nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (self.requestFailed) {
                _requestFailed(nil,error);
            }
            
        }];
    }else{
        [self.manager POST:[self buildRequestUrl] parameters:self.postParams success:^(AFHTTPRequestOperation *operation, id responseObject)  {
            WGBaseModel *model = [self responseModelWithData:responseObject];
            if (self.requestSuccess) {
                _requestSuccess(model,nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (self.requestFailed) {
                _requestFailed(nil,error);
            }
        }];
    }
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGBaseModel alloc] initWithData:data error:nil];
}

@end
