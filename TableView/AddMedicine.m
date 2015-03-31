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

///array used ti insert a new object with the medications
@property (strong, nonatomic) NSMutableArray *medicines;

@end

@implementation AddMedicine

- (void)viewDidLoad {
    [super viewDidLoad];
    self.medicines = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//insert new row - return the rows number that is the number from objects medicines
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.medicines count];
}

//method add medication in the database and in the table if the text already written
- (IBAction)addMed:(id)sender {
    NSString *stringMed = self.editMed.text;
    if (![self.editMed.text isEqualToString: @""]) {
        
        [self.medicines insertObject:stringMed atIndex:0];
        [self.tableView reloadData];
        self.editMed.text = @"";
    }
}

//used to insert a new cell. This cell have a label with the medication inserted
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"MedicineCell";
    
    cellMedicine *medicineCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    medicineCell.medicine.text = self.medicines[indexPath.row];
    
    return  medicineCell;
}


@end
