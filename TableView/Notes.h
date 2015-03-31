//
//  Notes.h
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyEntry.h"

@interface Notes : UITableViewController

///class DailyEntry with properties - here (in Notes) is used to guard a mutableArray notes
@property (nonatomic, strong) DailyEntry *dailyEntry;

@end
