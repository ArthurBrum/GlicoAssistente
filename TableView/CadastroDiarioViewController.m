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

@interface CadastroDiarioViewController ()
@property (weak, nonatomic) IBOutlet UITextField *GlucoData;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property NSMutableArray *objects;
@property NSInteger cell;
@property (nonatomic, strong) DailyEntry *dailyEntry;
@end

@implementation CadastroDiarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cell = 1;
    
    self.dailyEntry = [[DailyEntry alloc] init];
    
    //Hides numeric pad when touch outside text field
    [self addTapGesture];
    
    [self.datePicker setMaximumDate: [NSDate date]];
    
    NSCalendar *calender = [NSCalendar currentCalendar] ;
    NSDateComponents *components = [calender components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
    
    NSDate *currentDate = [NSDate date];
    
//    NSDateComponents *yesterday = [[NSDateComponents alloc] init];
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *minDate = [calender dateByAddingComponents:components toDate:currentDate  options:0];
    NSLog(@"%@", minDate);
    
    [self.datePicker setMinimumDate: minDate];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   
    if(section == 0)
        self.cell = 1;
    else
        self.cell+=2;
    
    return self.cell;
}
- (IBAction)maximumUpdateDate:(id)sender {
    [self.datePicker setMaximumDate: [NSDate date]];

}


//Set text colors according glicose levels
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

- (IBAction)saveDatas:(id)sender {
    
    self.dailyEntry.glucose = [NSNumber numberWithInteger: [self.GlucoData.text integerValue]];
    self.dailyEntry.entryDate = self.datePicker.date;
    
    [self.dailyEntry saveNewEntry];
    
    self.GlucoData.text = @"";

}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
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
