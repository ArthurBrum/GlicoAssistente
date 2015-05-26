//
//  HistoricViewController.h
//  TableView
//
//  Created by Jessica Oliveira on 26/05/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface HistoricViewController : UIViewController <JTCalendarDataSource>
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) JTCalendar *calendar;

@end
