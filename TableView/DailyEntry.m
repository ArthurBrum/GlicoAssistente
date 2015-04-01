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


- (BOOL) saveNewEntry{
    BOOL inserted = NO;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Entity for table 'Entries'
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Entries" inManagedObjectContext: appDelegate.managedObjectContext];
    
    [entity setValue: self.glucose forKey:@"glycemicIndex"];
    [entity setValue:self.entryDate forKey:@"dateTime"];
    
    NSError *error;
    
    inserted = [appDelegate.managedObjectContext save: &error];
    if(inserted) NSLog(@"Success!!");
    [self fetchEntries];

    return inserted;
}

- (void) updateEntry{
    //To implement when editing old registers become available
}

- (void) fetchEntries{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //Create entity object for table 'Entries'
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entries" inManagedObjectContext:appDelegate.managedObjectContext];
    
    //Create fetch request
    NSFetchRequest *fetchRqst = [[NSFetchRequest alloc] init];
    [fetchRqst setEntity:entity];
    
    //Get all rows in utable array
    NSMutableArray *array = [[appDelegate.managedObjectContext executeFetchRequest:fetchRqst error:nil] mutableCopy];
    
    //Core data return each row as managed object to access through key-value
    for(NSManagedObject *obj in array){
        NSLog(@"Data: %@ ---- Glic: %@", [obj valueForKey:@"dateTime"], [obj valueForKey:@"glycemicIndex"]);
    }
        
}


@end
