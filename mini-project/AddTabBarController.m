//
//  AddTabBarController.m
//  mini-project
//
//  Created by Anne Lim on 7/8/14.
//  Copyright (c) 2014 Anne Lim. All rights reserved.
//

#import "AddTabBarController.h"
#import <Parse/Parse.h>
#import "AddRestaurantViewController.h"

@class AddRestaurantViewController;
@class SubmitViewController;

@interface AddTabBarController ()


@end

@implementation AddTabBarController

static PFObject *restaurant;

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
    restaurant = [PFObject objectWithClassName:@"Restaurant"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    /*PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];
    restaurant[@"Name"] = @"Dennys";
    restaurant[@"ClosingTimes"] = [NSArray arrayWithObjects: @82800, @82800, @82800, @79200,@79200,@79200,@79200, nil];
    restaurant[@"OpeningTimes"] = [NSArray arrayWithObjects: @21600, @21600, @21600, @21600,@21600,@21600,@21600, nil];
    
    [restaurant saveInBackground];*/
    
    AddRestaurantViewController *mon = [self.storyboard instantiateViewControllerWithIdentifier:@"mon"];
    double monopen;
    monopen = mon.openTime;
    NSLog(@"%f",monopen);

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
