//
//  City+CoreDataProperties.h
//  
//
//  Created by Adele on 1/31/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *areaName;
@property (nullable, nonatomic, retain) NSNumber *areaCode;

@end

NS_ASSUME_NONNULL_END
