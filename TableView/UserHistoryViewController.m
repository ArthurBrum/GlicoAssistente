//
//  UserHistory.m
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "UserHistoryViewController.h"
#import "SKSTableViewCell.h"
#import "SKSTableView.h"
#import "CoreData/CoreData.h"
#import "DailyEntry.h"
#import "Entries.h"
#import "Notes.h"
#import "Medications.h"

@interface UserHistoryViewController ()

///SKSTableView that shows the user history
@property (weak, nonatomic) IBOutlet SKSTableView *tableView;

///Recieves the data source matrix. The first element of each array is the main element of each cell.
@property (nonatomic, strong) NSArray *contents;

///Button to colapse expanded cells
@property (weak, nonatomic) IBOutlet UIButton *colapseButton;

@end

@implementation UserHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.SKSTableViewDelegate = self;
    
    // Do any additional setup after loading the view.
    
    // In order to expand just one cell at a time. If you set this value YES, when you expand an cell, the already-expanded cell is collapsed automatically.
    //    self.tableView.shouldExpandOnlyOneCell = YES;
    
    self.navigationItem.title = @"SKSTableView";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Collapse"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(collapseSubrows)];
    
    //[self setDataManipulationButton:UIBarButtonSystemItemRefresh];
    
    [self.colapseButton setTitle:@"Recolher" forState:normal];
    [self.tableView reloadData];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    _contents = nil;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 Turns NSSet in a concat NSString concatenated
 **/
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
        string = [string stringByAppendingString:@"-"];
    }
    
    return string;
}

-(NSArray*) arrayFromData: (NSMutableArray*) dataArray
{
    if ([dataArray count] == 0) {
        return nil;
    }
    
    NSArray* array = [[NSArray alloc] init];
    
    Entries *obj = [dataArray lastObject];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:[obj valueForKey:@"dateTime"]]; //here convert date in NSString
    NSString* dateAndGlic = [[NSString alloc] initWithFormat:@"%@  Glic: %@ mg/dL", convertedString, [obj valueForKey:@"glycemicIndex"]];
    
    NSString* notes = [self stringWithNSSet: [obj valueForKey:@"writedNotes"]];
    NSString* medicines = [self stringWithNSSet:[obj valueForKey:@"usedMeds"]];
    
    array = @[dateAndGlic, notes, medicines];
    
    [dataArray removeLastObject];
    
    return array;
}

- (NSArray *)contents
{
    
    if (!_contents)
    {
        _contents = [[NSArray alloc] init];
        
        NSMutableArray* dataArray = [DailyEntry fetchEntries];
        NSArray* array = [self arrayFromData:dataArray];
        
        while (array != nil) {
            _contents = [_contents arrayByAddingObject:array];
            array = [self arrayFromData:dataArray];
        }
        _contents = [NSArray arrayWithObject:_contents];
    }

    return _contents;
}




#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"Contents count: %lu", (unsigned long)[_contents count]);
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Contents[section] count: %lu", (unsigned long)[_contents[section] count]);
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Contents[indexPath.section] count: %lu", (unsigned long)[_contents[indexPath.section] count]);
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        return YES;
    }
    
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    
    cell.expandable = YES;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


#pragma mark - Actions

/**
 Colapse all subrows expanded
 **/
- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}


- (void)reloadTableViewWithData:(NSArray *)array
{
    self.contents = array;
    
    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

#pragma mark - Helpers

- (IBAction)collapseCells:(id)sender {
    [self collapseSubrows];
}

@end









