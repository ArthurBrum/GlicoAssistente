//
//  Notes.h
//  TableView
//
//  Created by Arthur Jacunas de Brum on 02/04/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entries;

@interface Notes : NSManagedObject

@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Entries *entries;

@end
