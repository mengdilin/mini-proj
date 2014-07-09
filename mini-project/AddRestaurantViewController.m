//
//  AddRestaurantViewController.m
//  mini-project
//
//  Created by Anne Lim on 7/8/14.
//  Copyright (c) 2014 Anne Lim. All rights reserved.
//

#import "AddRestaurantViewController.h"
#import <Parse/Parse.h>

@interface AddRestaurantViewController ()

@property (weak,nonatomic) IBOutlet UIDatePicker *datePickerOpen;
@property (weak,nonatomic) IBOutlet UIDatePicker *datePickerClose;



@end

@implementation AddRestaurantViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datePickerClose.datePickerMode = UIDatePickerModeTime;
    self.datePickerOpen.datePickerMode = UIDatePickerModeTime;
    //[self.navigationItem setHidesBackButton:YES animated:YES];

}

-(double)openTime
{
    double time = self.datePickerOpen.date.timeIntervalSince1970;
    while(time>86400)
    {
        time = time-86400;
    }
    
    return time;
}

-(double)closeTime
{
    double time = self.datePickerClose.date.timeIntervalSince1970;
    while(time>86400)
    {
        time = time-86400;
    }
    
    return time;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.datePickerOpen setDate:date animated:TRUE];

}

-(IBAction)endPressed:(id)sender
{
    NSDate * now = [[NSDate alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    NSDate * date = [cal dateFromComponents:comps];
    [self.datePicker setDate:date animated:TRUE];
>>>>>>> 2c7077c393b47a5260bc22f1f9ddbf2fea1a34ab
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
