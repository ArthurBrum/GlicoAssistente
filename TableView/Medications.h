//
//  Medications.h
//  TableView
//
//  Created by Arthur Jacunas de Brum on 02/04/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entries;

@interface Medications : NSManagedObject

@property (nonatomic, retain) NSString * medication;
@property (nonatomic, retain) Entries *entries;

@end
