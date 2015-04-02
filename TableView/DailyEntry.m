//
//  DailyEntry.m
//  TableView
//
//  Created by Jessica Oliveira on 31/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "DailyEntry.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"


@implementation DailyEntry

-(id) init
{
    self = [super init];
    if (self) {
        self.entryDate = [NSDate date];
        self.medicines = [NSMutableArray array];
        self.reminders = [NSMutableArray array];
        self.glucose = 0;
    }
    return self;
}

/*
 * Saves the data from the instance to DataCore
 */

- (BOOL) saveNewEntry{
    BOOL inserted = NO;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Entity for table 'Entries'
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entries" inManagedObjectContext: appDelegate.managedObjectContext];
//    Entries *entries = [[Entries alloc] initWithEntity:entity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
//    entries.glycemicIndex = self.glucose;
//    entries.dateTime = self.entryDate;
//    [entries addUsedMeds:[NSSet setWithArray:self.medicines]];
//    
//    [entity setValue: self.glucose forKey:@"glycemicIndex"];
//    [entity setValue: self.entryDate forKey:@"dateTime"];
//    [entity setValue: self.medicines forKey:@"usedMeds"];
//    [entity setValue: self.reminders forKey:@"writedNotes"];
    
    NSError *error;
    
    inserted = [appDelegate.managedObjectContext save: &error];
    if(inserted) NSLog(@"Success!!");
    NSMutableArray *array = [DailyEntry fetchEntries];
    
    //Core data return each row as managed object to access through key-value
    for(NSManagedObject *obj in array){
        NSLog(@"\n\nData: %@ \t Glic: %@ \t \n***NOTES***: %@ \t \n***MEDICATIONS***: %@", [obj valueForKey:@"dateTime"], [obj valueForKey:@"glycemicIndex"], [obj valueForKey:@"writedNotes"], [obj valueForKey:@"usedMeds"]);
    }

    
    return inserted;
}

- (void) updateEntry{
    //To implement when editing old registers become available
}


/*
 * Returns an array of all objects in the entity 'Entries' with respectives notes and medications
 */
+ (NSMutableArray *) fetchEntries{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //Create entity object for table 'Entries'
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entries" inManagedObjectContext:appDelegate.managedObjectContext];
    
    //Create fetch request
    NSFetchRequest *fetchRqst = [[NSFetchRequest alloc] init];
    [fetchRqst setEntity:entity];
    
    //Get all rows in utable array
    NSMutableArray *array = [[appDelegate.managedObjectContext executeFetchRequest:fetchRqst error:nil] mutableCopy];
    
    return array;
        
}


@end
