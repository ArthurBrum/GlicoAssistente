//
//  UserRegistreViewController.m
//  TableView
//
//  Created by Davi Rodrigues on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "UserRegistreViewController.h"

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

///Select user diabets type
@property (weak, nonatomic) IBOutlet UISegmentedControl *diabetsTypeSegmentedControl;
///Diabets type register - YES for 1, NO for 2
@property BOOL dtype;

///User medicine list
@property (weak, nonatomic) IBOutlet UITableView *medicenTableView;

@end

@implementation UserRegistreViewController

/**
 Saves user info and returns to root page
 **/
- (IBAction)doneRecord:(id)sender {
    //IMPLEMENTAR
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userName = @"Nome";
    _userAge = @"Idade";
    _userDoctor = @"Medico";
    _userHospital = @"Hospital de Referencia";
    _dtype = YES;
    
    [self refreshTextFields];
    
    self.nameTextField.clearsOnBeginEditing = YES;
    self.ageTextField.clearsOnBeginEditing = YES;
    self.doctorTextField.clearsOnBeginEditing = YES;
    self.hospitalTextField.clearsOnBeginEditing = YES;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField event handlers

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

#pragma mark  - Button handler

- (IBAction)doneButtonHanlder:(id)sender {
    //IMPLEMENTAR aqui: salvar dados
    
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

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    UITouch *touch = [[event allTouches] anyObject];
//    
//    //Verifique se o seu textField está com o teclado aberto e se o toque foi fora dele.
//    if ([self.nameTextField isFirstResponder] && [touch view] != self.nameTextField) {
//        [self.nameTextField resignFirstResponder];
//        self.userName = self.nameTextField.text;
//        
//        self.nameTextField.clearsOnBeginEditing = NO;
//    }
//    [super touchesBegan:touches withEvent:event];
//}

@end
