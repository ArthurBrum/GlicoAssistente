//
//  UserRegistreViewController.m
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "UserRegistreViewController.h"
#import "ViewController.h"
#import "cellMedicine.h"

@interface UserRegistreViewController ()

///DoneButton - saves info
@property (weak, nonatomic) IBOutlet UIButton *DoneButton;

///Receives user name in UserRegistreViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property NSString* userName;

///Receives user age in UserRegistreViewController
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property NSString* userAge;

///Receives user doctor's name
@property (weak, nonatomic) IBOutlet UITextField *doctorTextField;
@property NSString* userDoctor;

///Receives user hospital
@property (weak, nonatomic) IBOutlet UITextField *hospitalTextField;
///Stor users hospital to refresh text fiels and save data
@property NSString* userHospital;

///Receives user height
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
///Stor users height to refresh text fiels and save data
@property NSString* userHeight;

///Select user diabets type
@property (weak, nonatomic) IBOutlet UISegmentedControl *diabetsTypeSegmentedControl;
///Diabets type register - YES for 1, NO for 2
@property BOOL dtype;

///User medicine list
@property NSMutableArray* medicineList;

@property (weak, nonatomic) IBOutlet UITextField *medicineTextField;

@property (weak, nonatomic) IBOutlet UITableView *medicineTableView;
@end



@implementation UserRegistreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    _medicineList = [[NSMutableArray alloc] init];
    
    //Diabets type 1 was setted as default
    _dtype = YES;
    
    [self refreshTextFields];
    
    //All text fields are cleanning up on beging editing
    self.nameTextField.clearsOnBeginEditing = YES;
    self.ageTextField.clearsOnBeginEditing = YES;
    self.doctorTextField.clearsOnBeginEditing = YES;
    self.hospitalTextField.clearsOnBeginEditing = YES;
    self.heightTextField.clearsOnBeginEditing = YES;
    
    self.medicineTableView.editing = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.medicineList.count;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.medicineTableView setEditing:editing animated:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndenfier = @"MedicineCell";
    
    cellMedicine *cell = [tableView dequeueReusableCellWithIdentifier:cellIndenfier];
    
    if (cell == nil) {
        cell = [[cellMedicine alloc] init];
    }
    
    cell.medicine.text = [NSString stringWithFormat:@"%@", [self.medicineList objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - TextField methods
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    textField.clearsOnBeginEditing = NO;
    return YES;
}

-(void)refreshTextFields
{
    //Set text fields
    self.nameTextField.text = self.userName;
    self.ageTextField.text = self.userAge;
    self.doctorTextField.text = self.userDoctor;
    self.hospitalTextField.text = self.userHospital;
    self.heightTextField.text = self.userHeight;
}

/**
 Eneable edition in all text fields
 **/
-(void)editableTextFields
{
    self.nameTextField.enabled = YES;
    self.ageTextField.enabled = YES;
    self.doctorTextField.enabled = YES;
    self.hospitalTextField.enabled = YES;
    self.heightTextField.enabled = YES;
    self.medicineTextField.enabled = YES;
}

/**
 Disable edition in all text fields
 **/
-(void)nonEditableTextFields
{
    self.nameTextField.enabled = NO;
    self.ageTextField.enabled = NO;
    self.doctorTextField.enabled = NO;
    self.hospitalTextField.enabled = NO;
    self.heightTextField.enabled = NO;
    self.medicineTextField.enabled = NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.medicineList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.medicineTableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - TextField event handlers
/**
 
 **/
- (IBAction)nameTextFieldHandler:(id)sender {
    self.userName = self.nameTextField.text;
    [self textFieldShouldReturn:self.nameTextField];
}

- (IBAction)ageTextFieldHandler:(id)sender {
    self.userAge = self.ageTextField.text;
    [self textFieldShouldReturn:self.ageTextField];
}

- (IBAction)doctorTextFieldHandler:(id)sender {
    self.userDoctor = self.doctorTextField.text;
    [self textFieldShouldReturn:self.doctorTextField];
}

- (IBAction)hospitalTextFieldHandler:(id)sender {
    self.userHospital = self.hospitalTextField.text;
    [self textFieldShouldReturn:self.hospitalTextField];
}

- (IBAction)heightTextFieldHandler:(id)sender {
    self.userHeight = self.heightTextField.text;
    [self textFieldShouldReturn:self.heightTextField];
}

#pragma mark  - Button handler

- (IBAction)doneButtonHanlder:(id)sender {
    
    if ([self.DoneButton.titleLabel.text isEqual:@"Salvar"]) {
        [self.DoneButton setTitle:@"Editar" forState:normal];
        [self nonEditableTextFields];
        //IMPLEMENTAR aqui: salvar dados
        
    } else if ([self.DoneButton.titleLabel.text isEqual:@"Editar"]) {
        [self.DoneButton setTitle:@"Salvar" forState:normal];
        [self editableTextFields];
    }
    
}

- (IBAction)addButtonHandler:(id)sender {
    
    if (![self.medicineTextField.text isEqualToString:@""]) {
        [self.medicineList insertObject:self.medicineTextField.text atIndex:0];
        [self textFieldShouldReturn:self.medicineTextField];
        [self.medicineTableView reloadData];
        self.medicineTextField.text = @"";
    }
    
}

- (IBAction)segmentedControlHandler:(id)sender {
    if(self.diabetsTypeSegmentedControl.selectedSegmentIndex == 0)
    {
        self.dtype = YES;
    } else self.dtype = NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
