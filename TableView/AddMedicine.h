//
//  AddMedicine.h
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyEntry.h"

@interface AddMedicine : UIViewController <UITableViewDelegate,UITableViewDataSource> 

///class DailyEntry with properties - here (in addMedicine) is used to guard a mutableArray medicines
@property (nonatomic, strong) DailyEntry *dailyEntry;

@end
