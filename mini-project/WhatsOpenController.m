//
//  WhatsOpenController.m
//  mini-project
//
//  Created by Milica Kolundzija on 7/8/14.
//  Copyright (c) 2014 Milica Kolundzija. All rights reserved.
//

#import "WhatsOpenController.h"
#import <Parse/Parse.h>

@interface WhatsOpenController ()

@property (nonatomic) NSInteger numOpen;
@property (nonatomic, copy) NSMutableArray *open;

@end


@implementation WhatsOpenController

// Designated initializer
- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return number of open restaurants
    return self.numOpen;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create a cell for a restaurant
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:@"UITableViewCell"];
    PFObject *restaurant = self.open[indexPath.row];
    cell.textLabel.text = [restaurant objectForKey:@"Name"];
    cell.detailTextLabel.text = [restaurant objectForKey:@"Location"];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Figure out which restaurants are open
    [self openRestaurants];
}

- (void)openRestaurants {
    // From the current date and time, get the current weekday, hour and minute
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute
                                                      fromDate:currentDate];
    NSInteger weekday = [components weekday];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    // Calculate how many minutes have passed since midnight
    NSInteger minutesSinceMidnight = 60 * hour + minute;
    
    NSArray *allRestaurants, *opens, *closes;
    
    // Load all restaurants into 'allRestaurants'
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    allRestaurants = [query findObjects];
    
    // Prepare to record open restaurants
    NSMutableArray *newOpen = [[NSMutableArray alloc] init];
    
    for (PFObject *restaurant in allRestaurants) {
        // Load opening and closing times
        opens = [restaurant objectForKey:@"OpeningTimes"];
        closes = [restaurant objectForKey:@"ClosingTimes"];
        // Check if the restaurant is open
        if ([opens[weekday] intValue] <= minutesSinceMidnight
                    && [closes[weekday] intValue] >= minutesSinceMidnight) {
            [newOpen addObject:restaurant];
        }
    }
    // Update 'self.open' and 'self.numOpen'
    self.open = newOpen;
    self.numOpen = [self.open count];
}

@end
