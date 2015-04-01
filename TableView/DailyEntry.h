//
//  DailyEntry.h
//  TableView
//
//  Created by Jessica Oliveira on 31/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyEntry : NSObject 

@property (nonatomic, strong) NSDate *entryDate;
@property (nonatomic) NSNumber *glucose;
@property (nonatomic, strong) NSMutableArray *medicines;
@property (nonatomic, strong) NSMutableArray *reminders;

- (BOOL) saveNewEntry;
- (void) fetchEntries;

@end
