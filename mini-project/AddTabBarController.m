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

@interface AddTabBarController () <AddRestaurantViewControllerDelegate>


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
    for (AddRestaurantViewController *tabVC in self.viewControllers) {
        if ([tabVC isKindOfClass:[AddRestaurantViewController class]]) {
            tabVC.delegate = self;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    PFObject *restaurant = [PFObject objectWithClassName:@"Restaurant"];
    restaurant[@"Name"] = @"Dennys";
    restaurant[@"ClosingTimes"] = [NSArray arrayWithObjects: @82800, @82800, @82800, @79200,@79200,@79200,@79200, nil];
    restaurant[@"OpeningTimes"] = [NSArray arrayWithObjects: @10800, @10800, @10800, @10800,@10800,@10800,@10800, nil];
    
    [restaurant saveInBackground];
    
    AddRestaurantViewController *mon = [self.storyboard instantiateViewControllerWithIdentifier:@"mon"];
    
    
    double time = mon.openDate.timeIntervalSince1970;
    while(time>86400)
    {
        time = time-86400;
    }
    NSLog(@"%f",time);

}

- (void)addViewController:(AddRestaurantViewController *)controller didSelectOpenDate:(NSDate *)openDate
{
    [self.addTabBarDelegate addTabBarViewController:self
                                  didSelectOpenDate:openDate
                                                day:controller.restorationIdentifier];
    NSLog(@"date is: %@", openDate);
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
