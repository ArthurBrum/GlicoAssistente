//
//  TableViewController.m
//  TableView
//
//  Created by Jessica Oliveira on 26/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "CadastroDiarioViewController.h"
#import "ViewController.h"
#import "DailyEntry.h"
#import "AddMedicine.h"
#import "NotesViewController.h"
#import "UserHistoryViewController.h"

@interface CadastroDiarioViewController ()

///Receives cadastre date glucose
@property (weak, nonatomic) IBOutlet UITextField *GlucoData;

///Receives day, hours and minutes in DatePicker
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

///Receives cells number because the number is alterated to each sections
@property NSInteger cell;

///Receives the class Daily entry with properties important in program
@property (nonatomic, strong) DailyEntry *dailyEntry;

@end

@implementation CadastroDiarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initiate cell with one
    self.cell = 1;
    
    //alloc class
    self.dailyEntry = [[DailyEntry alloc] init];
    
    //Hides numeric pad when touch outside text field
    [self addTapGesture];
    
    //maximum date in date picker is the current time
    [self.datePicker setMaximumDate: [NSDate date]];
    
    //configuration of the minimum time - this minimum time is 24 hours ago
    NSCalendar *calender = [NSCalendar currentCalendar] ;
    NSDateComponents *components = [calender components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
    
    NSDate *currentDate = [NSDate date];
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *minDate = [calender dateByAddingComponents:components toDate:currentDate  options:0];
    
    [self.datePicker setMinimumDate: minDate];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/**
 configuration the delete cell
 @return - NSInteger
 @param - UITableView
 **/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

/**
 configuration the delete cell
 @return - NSInteger
 @param - UITableView : NSInteger
 **/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0)
        //section one
        self.cell = 1;
    else
        //section two
        self.cell+=2;
    
    return self.cell;
}

#pragma mark - config dates
/**
 update the maximum time with the current time in datepicker
 **/
- (IBAction)maximumUpdateDate:(id)sender {
    [self.datePicker setMaximumDate: [NSDate date]];

}

/** 
 Set text colors according glicose levels
 **/
- (IBAction)glucoReview:(id)sender {
    NSString *GlucoDataController = self.GlucoData.text;
    if ([GlucoDataController intValue] >= 200) {
        self.GlucoData.textColor =[UIColor redColor];
    }else{
        if ([GlucoDataController intValue] <=75) {
            self.GlucoData.textColor =[UIColor orangeColor];
        }else{
           
                self.GlucoData.textColor =[UIColor greenColor];
            
        }
    }
}

#pragma mark - cells
/**
 Save datas
 **/
- (IBAction)saveDatas:(id)sender {
    
    self.dailyEntry.glucose = [NSNumber numberWithInteger: [self.GlucoData.text integerValue]];
    self.dailyEntry.entryDate = self.datePicker.date;
    
    [self.dailyEntry saveNewEntry];
    
    self.GlucoData.text = @"";

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
 disable the delete/edit row
 **/
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

/**
 Override to support rearranging the table view.
 **/
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

/**
 Override to support conditional rearranging of the table view.
 **/
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Navigation

/**
 In a storyboard-based application, you will often want to do a little preparation before navigation
 **/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AddMedicine"]) {
        AddMedicine *addMedicineViewController = segue.destinationViewController;
        addMedicineViewController.dailyEntry = self.dailyEntry;
    }else
    if([segue.identifier isEqualToString:@"AddNotesTableViewController"]){
        NotesViewController *adddNotesTableViewController = segue.destinationViewController;
        adddNotesTableViewController.dailyEntry = self.dailyEntry;
    }
}

#pragma mark - Hide-keyboard methods

- (void) addTapGesture {
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = FALSE;
    [self.view addGestureRecognizer:tapper];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}


@end
