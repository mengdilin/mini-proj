//
//  ViewController.m
//  mini-project
//
//  Created by Mengdi Lin on 7/8/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![PFUser currentUser])
    {
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        
        [logInViewController setSignUpController:signUpViewController];
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    PFUser *user = [PFUser currentUser];
    NSString *username = [NSString stringWithFormat:@"%@",user.username];
    self.usernameLabel.text=username;
    [self.view setNeedsDisplay];
}

-(BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    if(username && password &&username.length !=0 && password.length!=0)
    {
        return YES;
    }
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Fill out everything" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:nil] show];
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//sent to the delegate when a PFUser is logged in. Dismiss login view cont
-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"failed to login");
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete=YES;
    //info = all of submitted data
    for(id key in info)
    {
        NSString *field = info[key];
        if(!field || field.length==0)
        {
            informationComplete=NO;
            break;
        }
    }
    if(!informationComplete)
    {
        [[[UIAlertView alloc] initWithTitle:@"Missing info" message:@"fill out all info" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
    return informationComplete;
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"sign up failed");
}

-(void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"dismissed sign up");
}
@end
