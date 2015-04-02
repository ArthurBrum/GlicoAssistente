//
//  Entries.h
//  TableView
//
//  Created by Jessica Oliveira on 02/04/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medications, Notes;

@interface Entries : NSManagedObject

@property (nonatomic, retain) NSDate * dateTime;
@property (nonatomic, retain) NSNumber * glycemicIndex;
@property (nonatomic, retain) NSSet *usedMeds;
@property (nonatomic, retain) NSSet *writedNotes;
@end

@interface Entries (CoreDataGeneratedAccessors)

- (void)addUsedMedsObject:(Medications *)value;
- (void)removeUsedMedsObject:(Medications *)value;
- (void)addUsedMeds:(NSSet *)values;
- (void)removeUsedMeds:(NSSet *)values;

- (void)addWritedNotesObject:(Notes *)value;
- (void)removeWritedNotesObject:(Notes *)value;
- (void)addWritedNotes:(NSSet *)values;
- (void)removeWritedNotes:(NSSet *)values;

@end
