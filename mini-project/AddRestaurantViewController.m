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
- (IBAction)datePickerValueChanged:(UIDatePicker *)sender;




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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    if ([sender isEqual:self.datePickerOpen]) {
        [self.delegate addViewController:self
                       didSelectOpenDate:sender.date];
    } else if ([sender isEqual:self.datePickerClose]) {
        // nothing yet!

    }
    
}
@end
