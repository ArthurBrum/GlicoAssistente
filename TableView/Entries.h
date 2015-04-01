//
//  Entries.h
//  TableView
//
//  Created by Arthur Jacunas de Brum on 31/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Medications, Notes;

@interface Entries : NSManagedObject

@property (nonatomic, retain) NSDate * dateTime;
@property (nonatomic, retain) NSNumber * glycemicIndex;
@property (nonatomic, retain) Medications *usedMeds;
@property (nonatomic, retain) Notes *writedNotes;

@end
