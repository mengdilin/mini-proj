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
@property (nonatomic) int secondsSinceMidnightOpen;
@property (nonatomic) int secondsSinceMidnightClose;


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

-(IBAction)dismiss:(id)sender
{
    NSLog(@"SPOT5");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"SPOT6");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    //PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];
    //restaurant[@"Name"] = @"Sean Plott";
    //[restaurant saveInBackground];
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
