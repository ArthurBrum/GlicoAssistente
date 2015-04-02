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

- (NSArray *)contents
{
    if (!_contents)
    {
        _contents = @[
                      @[
                          @[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
                          @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
                          @[@"Section0_Row2"]],
                      ];
    }
    
    return _contents;
}




#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
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

/*- (void)refreshData
{
    NSArray *array = @[
                       @[
                           @[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
                           @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
                           @[@"Section0_Row2"]
                           ]
                       ];
    [self reloadTableViewWithData:array];
    
    [self setDataManipulationButton:UIBarButtonSystemItemUndo];
}*/

/*- (void)undoData
{
    [self reloadTableViewWithData:nil];
    
    [self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}*/

- (void)reloadTableViewWithData:(NSArray *)array
{
    self.contents = array;
    
    // Refresh data not scrolling
    //    [self.tableView refreshData];
    
    [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

#pragma mark - Helpers

- (IBAction)collapseCells:(id)sender {
    [self collapseSubrows];
}

@end









