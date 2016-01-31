//
//  Industry+CoreDataProperties.h
//  
//
//  Created by Adele on 1/31/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Industry.h"

NS_ASSUME_NONNULL_BEGIN

@interface Industry (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *objId;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
