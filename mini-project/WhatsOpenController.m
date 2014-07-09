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
@property (nonatomic) NSDateComponents *currentComponents;

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
    // Recycle a cell or create a new one
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Get the appropriate restaurant
    PFObject *restaurant = self.open[indexPath.row];
    
    // Load opening and closing times
    NSArray *openingTimes = [restaurant objectForKey:@"OpeningTimes"];
    NSArray *closingTimes = [restaurant objectForKey:@"ClosingTimes"];
    
    // Get information about the current time
    NSInteger weekday = [self.currentComponents weekday];
    NSInteger minutesSinceMidnight = 60 * [self.currentComponents hour] + [self.currentComponents minute];

    // Get the closing time for the restaurant
    NSInteger closingTime = [closingTimes[weekday] intValue];
    
    // Does the special case apply? E.g. if it's 2 am and a place closes at 3 am, the 3 am will be the closing time for the previous day
    if (([openingTimes[(weekday - 1) % 7] intValue] >= [closingTimes[(weekday - 1) % 7] intValue]) && ([closingTimes[(weekday - 1) % 7] intValue] >= minutesSinceMidnight)) {
        closingTime = [closingTimes[(weekday - 1) % 7] intValue];
    }
    
    // Another special case, if a place stays open
    NSInteger temp = weekday;
    NSInteger count = 0;
    while (([closingTimes[temp] intValue] == ([openingTimes[(temp + 1) % 7] intValue] - 1) % (60 * 24)) && count < 8) {
        temp++;
        temp %= 7;
        count++;
    }
    
    // Is the place open 24/7?
    if (count == 8) {
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ (open 24/7)", [restaurant objectForKey:@"Name"]];
        cell.detailTextLabel.text = [restaurant objectForKey:@"Location"];
        return cell;
    }
    
    // Not open 24/7, but still have to do some calculation
    if (count) {
        closingTime = [closingTimes[temp] intValue];
        if ([openingTimes[temp] intValue] >= [closingTimes[temp] intValue]) {
            closingTime += 24 * 60;
        }
        closingTime += count * 24 * 60;
    }
    
    // Calculate remaining time until restaurant closes
    NSInteger remainingMinutes = closingTime - minutesSinceMidnight;
    NSInteger remainingHours = remainingMinutes / 60;
    remainingMinutes %= 60;
    
    // Prepare for display
    if (remainingHours) {
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ (%d h %d m left)", [restaurant objectForKey:@"Name"], (int)remainingHours, (int)remainingMinutes];
    }
    else {
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ (%d m left)", [restaurant objectForKey:@"Name"], (int)remainingMinutes];
    }
    
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
    
    NSArray *allRestaurants, *openingTimes, *closingTimes;
    
    // Load all restaurants into 'allRestaurants'
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    allRestaurants = [query findObjects];
    
    // Prepare to record open restaurants
    NSMutableArray *newOpen = [[NSMutableArray alloc] init];
    
    // Check each restaurant
    for (PFObject *restaurant in allRestaurants) {
        
        // Load opening and closing times
        openingTimes = [restaurant objectForKey:@"OpeningTimes"];
        closingTimes = [restaurant objectForKey:@"ClosingTimes"];
        
        // Check if the restaurant is open
        if ([openingTimes[weekday] intValue] <= minutesSinceMidnight
                    && [closingTimes[weekday] intValue] >= minutesSinceMidnight) {
            [newOpen addObject:restaurant];
        }
        
        // Does the special case apply? E.g. if it's 2 am and a place closes at 3 am, the 3 am will be the closing time for the previous day.
        else if (([openingTimes[(weekday - 1) % 7] intValue] >= [closingTimes[(weekday - 1) % 7] intValue]) && ([closingTimes[(weekday - 1) % 7] intValue] >= minutesSinceMidnight)) {
            [newOpen addObject:restaurant];
        }
    }
    // Update 'self.open', 'self.numOpen' and 'self.currentComponents'
    self.open = newOpen;
    self.numOpen = [self.open count];
    self.currentComponents = components;
}

@end
