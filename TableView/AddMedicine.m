//
//  AddMedicine.m
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "AddMedicine.h"
#import "cellMedicine.h"

@interface AddMedicine ()

///text field used to insert a new medicine - outside the medications already registered
@property (weak, nonatomic) IBOutlet UITextField *editMed;

///table viem in the Medicine
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddMedicine

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.dailyEntry.medicines count];
}

/**
 permission of edition
 @return - void
 @param - BOOL : BOOL
 **/
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

/**
 close the keyboard
 @return - BOOL
 @param - UITextField
 **/
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    textField.clearsOnBeginEditing = NO;
    return YES;
}

- (IBAction)enter:(id)sender {
    NSString *stringMed = self.editMed.text;
    
    if (![self.editMed.text isEqualToString: @""]) {
        
        [self.dailyEntry.medicines insertObject:stringMed atIndex:0];
        [self textFieldShouldReturn:self.editMed];
        [self.tableView reloadData];
        
        //back with the text field clean
        self.editMed.text = @"";
    }
    
    //call method that it will close the keyboard
    [self textFieldShouldReturn:self.editMed];

    
}

/**
 method add medication in the database and in the table if the text already written
**/
- (IBAction)addMed:(id)sender {
    NSString *stringMed = self.editMed.text;
    
    if (![self.editMed.text isEqualToString: @""]) {
        
        [self.dailyEntry.medicines insertObject:stringMed atIndex:0];
        [self textFieldShouldReturn:self.editMed];
        [self.tableView reloadData];
        
        //back with the text field clean
        self.editMed.text = @"";
    }
}

/**
 configuration the delete cell
 @return - void
 @param - UITableView : UITableViewCellEditingStyle
 **/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dailyEntry.medicines removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/**
 used to insert a new cell. This cell have a label with the medication inserted
 @return - UITableViewCell
 @param - UITableView : NSIndexPath
 **/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"MedicineCell";
    
    cellMedicine *medicineCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    medicineCell.medicine.text = self.dailyEntry.medicines[indexPath.row];
    
    return  medicineCell;
}

@end
