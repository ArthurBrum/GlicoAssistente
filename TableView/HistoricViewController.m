//
//  HistoricViewController.m
//  TableView
//
//  Created by Jessica Oliveira on 26/05/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "HistoricViewController.h"
#import "DataCell.h"
#import "DailyEntry.h"

@interface HistoricViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;

@property (nonatomic, strong) DailyEntry *dailyEntry;

@end

@implementation HistoricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendar = [JTCalendar new];
    
    {
        
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            
            NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
            
            return [NSString stringWithFormat:@"%ld\n%@", comps.year, monthText];
        };
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self.calendar reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"%@", date);
}

- (IBAction)changeMode:(id)sender {
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

- (void)transitionExample
{
    CGFloat newHeight = 200;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 50.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Table view data source

/**
 insert new row - return the rows number that is the number from objects medicines
 @return - NSInteger
 @param - UITableView : NSInteger
 **/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //dailyEntry pulled from last screen - it is a MutableArray
    return [self.contents count];
}

/**
 disable the delete/edit row
 **/
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

/**
 Override to support editing the table view.
 @return - void
 @param - UITableView : UITableViewCellEditingStyle : NSIndexPath
 **/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

/**
 used to insert a new cell. This cell have a label with the medication inserted
 @return - UITableViewCell
 @param - UITableView : NSIndexPath
 **/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"DataCell";
    
     DataCell *dataCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    dataCell.dataLabel.text = self.dailyEntry.medicines[indexPath.row];
    
    return  dataCell;
}



@end
