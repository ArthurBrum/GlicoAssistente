//
//  UserRegistreViewController.m
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "UserRegistreViewController.h"
#import "ViewController.h"

@interface UserRegistreViewController ()

///DoneButton - saves info and returns to root page
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
@property NSString* userHospital;

///Receives user height
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property NSString* userHeight;

///Select user diabets type
@property (weak, nonatomic) IBOutlet UISegmentedControl *diabetsTypeSegmentedControl;
///Diabets type register - YES for 1, NO for 2
@property BOOL dtype;

///User medicine list
@property NSMutableArray* medicineList;

@property (weak, nonatomic) IBOutlet UITextField *medicineTextField;

@end

@implementation UserRegistreViewController

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.medicineList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndenfier = @"Indentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndenfier];
    
//    if (cell == nil) {
//        
//        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIndenfier]];
//        
//    }

    
//    UILabel *nameLabel = (UILabel*) [cell viewWithTag:200];
//    UILabel *billLabel = (UILabel*) [cell viewWithTag:200];
//    Person *personrow = [leaves objectatindex:[indexpath row]];
//    nameLabel.text = personatrow.personname;
//    NSString *bill = [NSString stringWithFormat:csdc
//                      ];
//    billlabel.text = bill;
//    return cell;
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _medicineList = [[NSMutableArray alloc] init];
    
    _userName = @"Nome";
    _userAge = @"Idade";
    _userDoctor = @"Medico";
    _userHospital = @"Hospital de Referencia";
    _userHeight = @"Altura";
    _dtype = YES;
    
    [self refreshTextFields];
    
    self.nameTextField.clearsOnBeginEditing = YES;
    self.ageTextField.clearsOnBeginEditing = YES;
    self.doctorTextField.clearsOnBeginEditing = YES;
    self.hospitalTextField.clearsOnBeginEditing = YES;
    self.heightTextField.clearsOnBeginEditing = YES;
    
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editableTextFields
{
    self.nameTextField.enabled = YES;
    self.ageTextField.enabled = YES;
    self.doctorTextField.enabled = YES;
    self.hospitalTextField.enabled = YES;
    self.heightTextField.enabled = YES;
}

-(void)nonEditableTextFields
{
    self.nameTextField.enabled = NO;
    self.ageTextField.enabled = NO;
    self.doctorTextField.enabled = NO;
    self.hospitalTextField.enabled = NO;
    self.heightTextField.enabled = NO;
}

#pragma mark - TextField event handlers
/**
 Saves na
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
    [self.medicineList addObject:self.medicineTextField.text];
    self.medicineTextField.text = @"";
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
