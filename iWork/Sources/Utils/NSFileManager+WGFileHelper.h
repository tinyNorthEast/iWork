//
//  NSFileManager+WGFileHelper.h
//  iWork
//
//  Created by Adele on 12/21/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (WGFileHelper)

- (float)fileSizeAtPath:(NSString *)path;

- (void)clearCache:(NSString *)path;

@end
