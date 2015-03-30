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
@property (weak, nonatomic) IBOutlet UITextField *editMed;
//@property (weak, nonatomic) IBOutlet UILabel *Med;
//@property (weak, nonatomic) IBOutlet UITableViewCell *cellMed;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (IBAction)addMed:(id)sender {
    NSString *stringMed = self.editMed.text;
  //  [changeLabel: stringMed];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  0;
}


@end
