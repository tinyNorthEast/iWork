//
//  WGFavoriteListRequest.m
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGFavoriteListRequest.h"

#import "NSMutableDictionary+WGExtension.h"
#import "WGGlobal.h"
#import "WGFavoriteListModel.h"

@implementation WGFavoriteListRequest

- (instancetype)initWithFavoritType:(FavoriteSearch)type{
    self = [super init];
    if (self) {
        
        //        [self.postParams safeSetValue:[[NSString stringDecodingByMD5:[[WGGlobal sharedInstance] userToken]] lowercaseString] forKey:@"password"];
        [self.getParams safeSetValue:@(type) forKey:@"searchType"];
        [self.getParams safeSetValue:[[WGGlobal sharedInstance] userToken] forKey:@"token"];
        return self;
    }
    return nil;
}
- (NSString *)pathName{
    return @"api/v1/attention/find.action";
}

- (WGHTTPRequestMethod)requestMethod{
    return WGHTTPRequestMethodGET;
}

- (WGBaseModel *)responseModelWithData:(id)data{
    return [[WGFavoriteListModel alloc] initWithDictionary:data error:nil];
}

@end
