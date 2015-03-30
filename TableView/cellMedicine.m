//
//  cellMedicine.m
//  TableView
//
//  Created by Jessica Oliveira on 30/03/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "cellMedicine.h"
@interface cellMedicine ()

@property (weak, nonatomic) IBOutlet UILabel *medicine;

@property (weak, nonatomic) IBOutlet UIView *cellMed;

@end


@implementation cellMedicine

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) changeLabel: (NSString*) medicineWrite {
    self.medicine.text = medicineWrite;
    
}

@end
