//
//  NSMutableDictionary+WGExtension.h
//  iWork
//
//  Created by Adele on 11/27/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (WGExtension)

- (void)safeSetValue:(id)aValue forKey:(NSString *)aKey;

@end
