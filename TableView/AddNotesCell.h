//
//  AddNotesCell.h
//  TableView
//
//  Created by Jessica Oliveira on 31/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNotesCell : UITableViewCell

///Receives reminders from user in Table Notes
@property (strong, nonatomic) IBOutlet UITextField *writeNote;

@end
