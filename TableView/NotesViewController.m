//
//  Notes.m
//  TableView
//
//  Created by Jessica Oliveira on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "NotesViewController.h"
#import "ViewController.h"
#import "AddNotesCell.h"

@interface NotesViewController()

//@property NSMutableArray *objects;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation NotesViewController
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*item button edit used to del the cell*/
     self.navigationItem.rightBarButtonItem = self.editButtonItem;

    if([self.dailyEntry.reminders count] == 0)
        [self.dailyEntry.reminders insertObject:@"" atIndex:0];
    
}

//recall all the cell
- (void)viewWillDisappear:(BOOL)animated
{
    for (int i = 0; i < [self.dailyEntry.reminders count]; i++) {
        
        AddNotesCell *cell = (AddNotesCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if(![cell.writeNote.text isEqualToString:@""])
            self.dailyEntry.reminders[i] = cell.writeNote.text;
       
    }
    NSLog(@"-%@", self.dailyEntry.reminders);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    textField.clearsOnBeginEditing = NO;
    return YES;
}

- (IBAction)entrerNextNote:(id)sender {
    
    AddNotesCell *noteWrite;
    noteWrite = (AddNotesCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //verificate if the first text field cell has been written
    if(![noteWrite.writeNote.text isEqualToString: @""]){
        for (int i = 0; i < [self.dailyEntry.reminders count]; i++) {
            AddNotesCell *cell = (AddNotesCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            self.dailyEntry.reminders[i] = cell.writeNote.text;
        }
        
        [self.dailyEntry.reminders insertObject:@"" atIndex:0];
        [self.tableView reloadData];
    }
    [self textFieldShouldReturn:noteWrite.writeNote];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    AddNotesCell *noteWrite;
    noteWrite = (AddNotesCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    
    //verificate if the first text field cell has been written
    if(![noteWrite.writeNote.text isEqualToString: @""] && indexPath.row != 0){

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dailyEntry.reminders removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
    
    }
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *object = self.dailyEntry.reminders[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View
/*return number of sections*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/*return number rows in section*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dailyEntry.reminders count];
}

/*copy the cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"addNotes";
    
    AddNotesCell *notesCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    notesCell.writeNote.text = self.dailyEntry.reminders[indexPath.row];
    
    return  notesCell;
}

/*row can edit*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end

