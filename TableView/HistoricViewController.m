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
#import "Entries.h"
#import "Notes.h"
#import "Medications.h"
#import "UIColor+FSPalette.h"


@interface HistoricViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;

@property (nonatomic, strong) DailyEntry *dailyEntry;

@end

@implementation HistoricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contents = [NSMutableArray array];
    
    self.calendar = [JTCalendar new];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self.calendar reloadData];
    
    [self setContet];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

#pragma mark - calendar
/**
 event in calendar - the marking
 **/
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

/**
 selected date - here shows the historic in this date
 **/
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    [self setContet];
    [self.tableView reloadData];

    NSLog(@"%@", date);
    
}

#pragma mark - button for minimize
/**
 minimize calendar
 **/
- (IBAction)changeMode:(id)sender {
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

/**
 minimize calendar action
 **/
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

#pragma mark - Config contents

/**
 Add all datas in the historic of day
 **/
-(void) setContet{
    NSMutableArray* dataArray = [DailyEntry fetchEntries];
    
    Entries *obj = [dataArray lastObject];
    
    // here we create NSDateFormatter object for change the Format of date..
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // here set format which you want...
    [dateFormatter setDateFormat:@"HH:mm"];
    //here convert date in NSString
    NSString *string = @"Hora:   ";
    NSString *convertedString = [dateFormatter stringFromDate:[obj valueForKey:@"dateTime"]];
    string = [string stringByAppendingString:convertedString];
    [self.contents addObject:string];
    
    
    //to pull data from core data
    string = @"Glucose:   ";
    NSString* dateAndGlic = [[NSString alloc] initWithFormat:@"%@", [obj valueForKey:@"glycemicIndex"]];
    string = [string stringByAppendingString:dateAndGlic];
    string = [string stringByAppendingString:@"  mg/dL"];
    [self.contents addObject: string];
    
    
    //config for to pull notes
    NSArray* notes = [self stringWithNSSet: [obj valueForKey:@"writedNotes"]];
    for(int i = 0; i < [notes count]; i++)
        [self.contents addObject:notes[i]];
    
    //config for to pull medicines
    NSArray* medicines = [self stringWithNSSet:[obj valueForKey:@"usedMeds"]];
    for(int i = 0; i < [medicines count]; i++)
        [self.contents addObject:medicines[i]];
}
/**
 Set the string for separete before
 **/
-(NSArray*) stringWithNSSet: (NSSet*) set
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[set allObjects]];
    
    NSString* string = [[NSString alloc] initWithFormat:@""];
    
    for (int arrayRange = 0; arrayRange < [array count]; arrayRange++) {
        
        // Returns a Boolean value that indicates whether the receiver is an instance of a
        // given class.
        if([[array objectAtIndex:arrayRange] isMemberOfClass:[Notes class]])
            string = [string stringByAppendingString:[[array objectAtIndex:arrayRange] note]];
        else
        {
            Medications *medications = [array objectAtIndex:arrayRange];
            string = [string stringByAppendingString: [medications medication]];
        }
        if (arrayRange != [array count] - 1) {
            string = [string stringByAppendingString:@"|"];
        }
    }
    NSArray *arrayFinal = [ string componentsSeparatedByString:@"|"];

    return arrayFinal;
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
    
    dataCell.dataLabel.text = self.contents[indexPath.row];
    
    if(indexPath.row == 0)
        dataCell.backgroundColor = [UIColor fsLightBlue];
    
    return  dataCell;
}

@end
