//
//  ChartViewController.m
//  TableView
//
//  Created by Jessica Oliveira on 02/04/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

#import "ChartViewController.h"
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

@interface ChartViewController ()

@end

@implementation ChartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self chart1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Creating the charts

-(FSLineChart*)chart1 {
    
    NSMutableArray *chartData = [[NSMutableArray alloc] initWithArray:@[@190, @170, @170, @196, @208, @204, @200, @190, @170,@180, @190, @175, @163, @178, @194, @182, @179, @200,@210, @210, @205, @200]];
    
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 160, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.gridStep = 7;
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}



@end
