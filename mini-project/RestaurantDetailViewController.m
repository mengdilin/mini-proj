//
//  RestaurantDetailViewController.m
//  mini-project
//
//  Created by Mengdi Lin on 7/8/14.
//  Copyright (c) 2014 Mengdi Lin. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import <Parse/Parse.h>
@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController
{
    NSString *openingHour, *closingHour;
    PFObject *currentRestaurant;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {

    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    [query selectKeys:@[@"Name",@"Location"]];
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute
                                                      fromDate:currentDate];
    int weekday = (int)[components weekday];
    //PFQuery *query1 = [PFQuery queryWithClassName:@"Restaurants"];
    //[query1 whereKey:@"Name" equalTo:self.name];
    
    //PFQuery *query2 = [PFQuery queryWithClassName:@"Restaurants"];
    //[query2 whereKey:@"Location" equalTo:self.location];
    //PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query1,query2]];
    /**
    [query whereKey:@"Name" equalTo:self.name];
    
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"Restaurants"];
    //[query1 whereKey:@"Location" equalTo:self.location];
    [query1 whereKeyExists:[@"Location"];
     
     **/
    //PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query,query1]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            //NSLog(@"here");
            for(PFObject *object in objects)
            {
                if(([object[@"Name"] isEqualToString:self.name]) && ([object[@"Location"] isEqualToString:self.location]))
                    {
            [object fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if(!error)
                {
                    currentRestaurant=object;
                    self.openingMinutesBeforeMidnight = [object[@"OpeningTimes"][weekday] intValue];
                    //NSLog(@"here within");
                    self.closingMinutesBeforeMidnight = [object[@"ClosingTimes"][weekday] intValue];
                    int closeHour = self.closingMinutesBeforeMidnight / 60;
                    //NSLog(@"%i",self.closingMinutesBeforeMidnight);
                    int closeMin = self.closingMinutesBeforeMidnight % 60;
                    if(closeMin==0)
                        closingHour = [NSString stringWithFormat:@"Closing: %i : %i0", closeHour,closeMin];
                    else if(closeMin<10)
                        closingHour = [NSString stringWithFormat:@"Closing: %i : %0i", closeHour,closeMin];
                    else
                        closingHour = [NSString stringWithFormat:@"Closing: %i : %i", closeHour,closeMin];
                    
                    
                    int openHour = self.openingMinutesBeforeMidnight / 60;
                    //NSLog(@"%i",self.openingMinutesBeforeMidnight);
                    int openMin = self.openingMinutesBeforeMidnight % 60;
                    if(openMin==0)
                        openingHour = [NSString stringWithFormat:@"Opening: %i : %i0", openHour,openMin];
                    else if(openMin<10)
                        openingHour = [NSString stringWithFormat:@"Opening: %i : %0i", openHour,openMin];
                    else
                        openingHour = [NSString stringWithFormat:@"Opening: %i : %i", openHour,openMin];
                    
                    self.openingHoursLabel.text=openingHour;
                    self.hoursLabel.text=closingHour;
                                        [self.view setNeedsDisplay];
                    
                    
                }
                else
                {
                    NSString *errorString = [error userInfo][@"error"];
                    NSLog(@"%@",errorString);
                }
                
            }];
                        break;
                    }
            }
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"%@",errorString);
        }
    }];

}

- (void)viewDidLoad
{
 
    [super viewDidLoad];
    self.nameLabel.text=self.name;
    self.locationLabel.text=[NSString stringWithFormat:@"Location: %@", self.location];
       [self.view setNeedsDisplay];
    [self.favoriteButton addTarget:self action:@selector(favoriteButtonPressed) forControlEvents:UIControlEventTouchUpInside];


    //[self.view setNeedsDisplay];
    // Do any additional setup after loading the view.
}

-(void)favoriteButtonPressed
{
    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationForKey:@"favorites"];
    [relation addObject: currentRestaurant];
    /**
    if(user[@"favorite"]!=nil)
    {
        [user addObject:currentRestaurant forKey:@"favorites"];
       // NSLog(@"%@",user[@"favorites"]);
    }
    else
    {
        NSArray *array = @[currentRestaurant];
        [user setObject:array forKey:@"favorites"];
       // NSLog(@"%@",user[@"favorites"]);
    }
     **/
   // NSLog(@"current res: %@",currentRestaurant);
    [user saveInBackground];
    
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

@end
