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
@property (weak, nonatomic) IBOutlet UILabel *today;
@property (weak, nonatomic) IBOutlet UILabel *day1;
@property (weak, nonatomic) IBOutlet UILabel *day2;
@property (weak, nonatomic) IBOutlet UILabel *day3;
@property (weak, nonatomic) IBOutlet UILabel *day4;
@property (weak, nonatomic) IBOutlet UILabel *day5;
@property (weak, nonatomic) IBOutlet UILabel *day6;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

@implementation ChartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self chart1]];
    NSString *formatter = @"dd/MM/yyyy";
    self.date.text = [self formatterDate:formatter];
    self.today.text = [self days:@"dd/MM":0];
    self.day1.text = [self days:@"dd/MM":-1];
    self.day2.text = [self days:@"dd/MM":-2];
    self.day3.text = [self days:@"dd/MM":-3];
    self.day4.text = [self days:@"dd/MM":-4];
    self.day5.text = [self days:@"dd/MM":-5];
    self.day6.text = [self days:@"dd/MM":-6];
}
-(NSString*) formatterDate: (NSString *)formatter{
    NSDate *currentDate;
    currentDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatter];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timeString = [dateFormatter stringFromDate:currentDate];
    
    return timeString;
}
-(NSString*) days: (NSString*) formatter: (int) valor{
    NSCalendar *calender = [NSCalendar currentCalendar] ;
    NSDateComponents *components = [calender components:(NSCalendarUnitDay) fromDate:[[NSDate alloc] init]];
    
    NSDate *currentDate = [NSDate date];
    
    [components setDay:valor];
    
    NSDate *Date = [calender dateByAddingComponents:components toDate:currentDate  options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatter];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timeString = [dateFormatter stringFromDate:Date];
    return timeString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Creating the charts

-(FSLineChart*)chart1 {
    
    NSMutableArray *chartData = [[NSMutableArray alloc] initWithArray:@[@190, @170, @170, @196, @208, @204, @200, @190, @170,@180, @190, @175, @163, @178, @194, @182, @179, @200,@210, @210, @205, @200]];
    
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 250)];
    
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
