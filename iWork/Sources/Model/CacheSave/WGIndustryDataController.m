//
//  WGIndustryDataController.m
//  iWork
//
//  Created by Adele on 1/31/16.
//  Copyright © 2016 impetusconsulting. All rights reserved.
//

#import "WGIndustryDataController.h"

#import "WGCoreDataController.h"
#import "Industry.h"
#import "WGIndustryModel.h"

@implementation WGIndustryDataController

+ (id)sharedInstance{
    static WGIndustryDataController *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (NSArray *)fetchIndustry{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Industry" inManagedObjectContext:[[WGCoreDataController sharedInstance] managedObjectContext]]];
    NSError *error = nil;
    NSArray *industrys = [[[WGCoreDataController sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    return industrys;
}
- (void)clearAllIndustrys
{
    NSFetchRequest *allIndustrys = [[NSFetchRequest alloc] init];
    [allIndustrys setEntity:[NSEntityDescription entityForName:@"Industry" inManagedObjectContext:[[WGCoreDataController sharedInstance] managedObjectContext]]];
    [allIndustrys setIncludesPropertyValues:NO];
    
    NSError *error = NULL;
    NSArray *industrys = [[[WGCoreDataController sharedInstance] managedObjectContext] executeFetchRequest:allIndustrys error:&error];
    
    for (NSManagedObject *aindustry in industrys) {
        [[[WGCoreDataController sharedInstance] managedObjectContext] deleteObject:aindustry];
    }
    
    [[WGCoreDataController sharedInstance] saveContext];
}

- (void)insertIndustry:(NSArray *)array{
    [self clearAllIndustrys];
    
    NSManagedObjectContext *context = [[WGCoreDataController sharedInstance] managedObjectContext];
    
    for (WGIndustryModel *model in array) {
        Industry *industry = [NSEntityDescription insertNewObjectForEntityForName:@"Industry" inManagedObjectContext:context];
        
        industry.objId = model.objId;
        industry.name = model.name;
    }
    [[WGCoreDataController sharedInstance] saveContext];
}


@end
