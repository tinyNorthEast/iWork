//
//  WGFavoriteListRequest.h
//  iWork
//
//  Created by Adele on 12/29/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBaseRequest.h"

typedef NS_ENUM(NSInteger, FavoriteSearch) {
    FavoriteSearch_To = 1,
    FavoriteSearch_From
};

@interface WGFavoriteListRequest : WGBaseRequest

- (instancetype)initWithFavoritType:(FavoriteSearch)type;

@end
