//
//  DailyEntry.m
//  TableView
//
//  Created by Jessica Oliveira on 31/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "DailyEntry.h"

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


@end
