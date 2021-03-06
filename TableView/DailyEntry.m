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
#import "Entries.h"
#import "Medications.h"
#import "Notes.h"


@implementation DailyEntry

-(id) init
{
    self = [super init];
    if (self) {
        self.entryDate = [NSDate date];
        self.medicines = [NSMutableArray array];
        self.reminders = [NSMutableArray array];
        self.usedMeds = [NSMutableArray array];
        self.writedNotes = [NSMutableArray array];
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
    
    // Getting strings and putting them into the array of medications
    for(NSString *med in self.reminders){
        
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext: appDelegate.managedObjectContext];
        if(![med isEqualToString:@""]){
            [entity setValue:med forKey:@"note"];
            [self.writedNotes addObject:entity];
        }
    }
    
    // Getting strings and putting them into the array of notes
    for(NSString *note in self.medicines){
        
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Medications" inManagedObjectContext: appDelegate.managedObjectContext];
        if(![note isEqualToString:@""]){
            [entity setValue:note forKey:@"medication"];
            [self.usedMeds addObject:entity];
        }
    }
    
    
    // Actually saving to CoreData
    [entity setValue:self.glucose forKey:@"glycemicIndex"];
    [entity setValue:self.entryDate forKey:@"dateTime"];
    [entity setValue:[NSSet setWithArray:self.usedMeds] forKey:@"usedMeds"];
    [entity setValue:[NSSet setWithArray:self.writedNotes] forKey:@"writedNotes"];

    
    NSError *error;
//    [appDelegate.managedObjectContext insertObject:entries];
    inserted = [appDelegate.managedObjectContext save: &error];
    if(inserted) NSLog(@"Success!!");
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

+ (NSMutableArray *) fetchEntriesForDay: (NSDate *) date {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //Create fetch request
    NSFetchRequest *fetchRqst = [[NSFetchRequest alloc] initWithEntityName:@"Entries"];

    NSDateComponents* startDateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    [startDateComps setHour:0];
    [startDateComps setMinute:0];
    [startDateComps setSecond:0];
    
    NSDate *startDate = [[NSCalendar currentCalendar] dateFromComponents:startDateComps];
    
    NSDateComponents* endDateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    [endDateComps setHour:23];
    [endDateComps setMinute:59];
    [endDateComps setSecond:59];
    
    NSDate *endDate = [[NSCalendar currentCalendar] dateFromComponents:endDateComps];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(dateTime >= %@) AND (dateTime < %@)",startDate, endDate];
    
    [fetchRqst setPredicate:predicate];
    
    //Get all rows in utable array
    NSMutableArray *array = [[appDelegate.managedObjectContext executeFetchRequest:fetchRqst error:nil] mutableCopy];
    
    return array;
    
}

@end
