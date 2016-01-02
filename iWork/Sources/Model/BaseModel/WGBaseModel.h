//
//  WGBaseModel.h
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "JSONModel.h"

#define TokenFailed 30003

@interface WGBaseModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *infoCode;

@property (nonatomic, copy) NSString<Optional> *message;

- (BOOL)isValid;

@end
