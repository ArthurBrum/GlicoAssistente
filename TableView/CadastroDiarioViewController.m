//
//  TableViewController.m
//  TableView
//
//  Created by Jessica Oliveira on 26/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "CadastroDiarioViewController.h"
#import "ViewController.h"

@interface CadastroDiarioViewController ()
@property (weak, nonatomic) IBOutlet UITextField *GlucoData;
@property NSMutableArray *objects;
@property NSInteger cell;
@end

@implementation CadastroDiarioViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cell = 1;
//     Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
//    
//     Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
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



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
}


@end
