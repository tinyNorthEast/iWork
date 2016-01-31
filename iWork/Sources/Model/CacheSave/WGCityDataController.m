//
//  WGCityDataController.m
//  iWork
//
//  Created by Adele on 1/31/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGCityDataController.h"

#import "WGCoreDataController.h"
#import "City.h"
#import "WGCityModel.h"

@implementation WGCityDataController

+ (id)sharedInstance{
    static WGCityDataController *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (NSArray *)fetchCitys{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"City" inManagedObjectContext:[[WGCoreDataController sharedInstance] managedObjectContext]]];
    NSError *error = nil;
    NSArray *citys = [[[WGCoreDataController sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    return citys;
}

- (void)clearAllCitys
{
    NSFetchRequest *allCitys = [[NSFetchRequest alloc] init];
    [allCitys setEntity:[NSEntityDescription entityForName:@"City" inManagedObjectContext:[[WGCoreDataController sharedInstance] managedObjectContext]]];
    [allCitys setIncludesPropertyValues:NO];
    
    NSError *error = NULL;
    NSArray *citys = [[[WGCoreDataController sharedInstance] managedObjectContext] executeFetchRequest:allCitys error:&error];
    
    for (NSManagedObject *acity in citys) {
        [[[WGCoreDataController sharedInstance] managedObjectContext] deleteObject:acity];
    }
    
    [[WGCoreDataController sharedInstance] saveContext];
}

- (void)insertCity:(NSArray *)array{
    [self clearAllCitys];
    
    NSManagedObjectContext *context = [[WGCoreDataController sharedInstance] managedObjectContext];
    
    for (WGCityModel *model in array) {
        City *city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:context];
        
        city.areaCode = model.areaCode;
        city.areaName = model.areaName;
    }
    
    [[WGCoreDataController sharedInstance] saveContext];
}


@end
