//
//  Notes.m
//  TableView
//
//  Created by Jessica Oliveira on 27/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "Notes.h"
#import "ViewController.h"
#import "AddNotesCell.h"

@interface Notes()

@property NSMutableArray *objects;


@end


@implementation Notes
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*item more +*/
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    /*add first object*/
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*add object in the table*/
- (void)insertNewObject:(id)sender {
    AddNotesCell *noteWrite;
    if(![noteWrite.textLabel isEqual: @""]){
        if (!self.objects) {
            self.objects = [[NSMutableArray alloc] init];
        }
        [self.objects insertObject:[NSDate date] atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
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
    return self.objects.count;
}

/*copy the cell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *addNotes = [tableView dequeueReusableCellWithIdentifier:@"addNotes" forIndexPath:indexPath];
    
    return addNotes;
}

/*row can edit*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end

