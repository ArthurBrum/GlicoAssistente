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
#import "UIColor+FSPalette.h"
#import "Entries.h"
#import "Notes.h"
#import "Medications.h"




@interface CadastroDiarioViewController ()
///Receives cadastre date glucose
@property (weak, nonatomic) IBOutlet UITextField *GlucoData;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *Edit;

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
    
    [self ConfigDatePicker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) ConfigDatePicker {
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

#pragma mark - Table view data source
/**
 configuration the return numbers cells
 @return - NSInteger
 @param - UITableView
 **/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

/**
 configuration the add cell
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
        self.cell+=5;
    
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
        self.GlucoData.textColor =[UIColor fsRed];
    }else{
        if ([GlucoDataController intValue] <=100) {
            self.GlucoData.textColor =[UIColor fsYellow];
        }else{
           
                self.GlucoData.textColor =[UIColor fsGreen];
            
        }
    }
}

#pragma mark - cells
/**
 Save datas
 **/
- (IBAction)saveDatas:(id)sender {
    if(![self.GlucoData.text isEqualToString:@""]){
        if ([self.Edit.title isEqualToString:@"Editar Anterior"]) {
            self.dailyEntry.glucose = [NSNumber numberWithInteger: [self.GlucoData.text integerValue]];
            self.dailyEntry.entryDate = self.datePicker.date;
    
            [self.dailyEntry saveNewEntry];
    
            self.Edit.title = @"Editar Anterior";
            self.GlucoData.text = @"";
        
            //alloc class
            self.dailyEntry = [[DailyEntry alloc] init];
        }else{
            self.Edit.title = @"Editar Anterior";
            self.dailyEntry.glucose = [NSNumber numberWithInteger: [self.GlucoData.text integerValue]];
            self.dailyEntry.entryDate = self.datePicker.date;
            
            [self.dailyEntry  updateEntry];
            
            self.Edit.title = @"Editar Anterior";
            self.GlucoData.text = @"";
        }
    }
    
}

- (IBAction)editLast:(id)sender {
    
    //stat edit - pull all last data
    if ([self.Edit.title isEqualToString:@"Editar Anterior"]) {
        self.Edit.title = @"Cancelar";
        
        NSMutableArray* dataArray = [DailyEntry fetchEntries];
        
        Entries *obj = [dataArray lastObject];
        
        // here we create NSDateFormatter object for change the Format of date..
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        // here set format which you want...
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
        
        //here convert date in NSString
        NSString *convertedString = [dateFormatter stringFromDate:[obj valueForKey:@"dateTime"]];
        
        //to pull data from core data
        NSString* dateAndGlic = [[NSString alloc] initWithFormat:@"%@", [obj valueForKey:@"glycemicIndex"]];
        
        //to wrtie in text field
        self.GlucoData.text = dateAndGlic;
        
        //to write in date picker
        self.datePicker.date = [dateFormatter dateFromString:convertedString];
        
        //config for to pull notes
        NSString* notes = [self stringWithNSSet: [obj valueForKey:@"writedNotes"]];
        
        NSArray *noteArray = [ notes componentsSeparatedByString:@"|"];
        
        self.dailyEntry.reminders = [NSMutableArray arrayWithArray:noteArray];
        
        //config for to pull medicines
        NSString* medicines = [self stringWithNSSet:[obj valueForKey:@"usedMeds"]];

       NSArray *medicinesArray = [ medicines componentsSeparatedByString:@"|"];
        
        self.dailyEntry.medicines = [NSMutableArray arrayWithArray:medicinesArray];
        
    }else{
        //stat cancel
        self.Edit.title = @"Editar Anterior";
        self.GlucoData.text = @"";
        [self ConfigDatePicker];
        [self.datePicker setDate: [NSDate date]];
        
        //alloc class
        self.dailyEntry = [[DailyEntry alloc] init];
    }
}

-(NSString*) stringWithNSSet: (NSSet*) set
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[set allObjects]];
    
    NSString* string = [[NSString alloc] initWithFormat:@""];
    
    for (int arrayRange = 0; arrayRange < [array count]; arrayRange++) {
        
        // Returns a Boolean value that indicates whether the receiver is an instance of a
        // given class.
        if([[array objectAtIndex:arrayRange] isMemberOfClass:[Notes class]]) string = [string stringByAppendingString:[[array objectAtIndex:arrayRange] note]];
        else
        {
            Medications *medications = [array objectAtIndex:arrayRange];
            string = [string stringByAppendingString: [medications medication]];
        }
        if (arrayRange != [array count] - 1) {
            string = [string stringByAppendingString:@"|"];
        }
        
    }
    
    return string;
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
