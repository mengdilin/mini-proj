//
//  WelcomeViewController.m
//  mini-project
//
//  Created by Anne Lim on 7/9/14.
//  Copyright (c) 2014 Anne Lim. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AddTabBarController.h"

@interface WelcomeViewController () <AddTabBarViewControllerDelegate>

@end

@implementation WelcomeViewController

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:nil action:nil];
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

- (void)addTabBarViewController:(AddTabBarController *)controller
              didSelectOpenDate:(NSDate *)openDate
                            day:(NSString *)dayAsString
{
    NSLog(@"WOOOO open at %@ on %@", openDate, dayAsString);
}

@end
