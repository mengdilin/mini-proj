//
//  FavoriteRestaurantTableViewController.m
//  mini-project
//
//  Created by Mengdi Lin on 7/9/14.
//  Copyright (c) 2014 Mengdi Lin. All rights reserved.
//

#import "FavoriteRestaurantTableViewController.h"
#import "RestaurantDetailViewController.h"
#import <Parse/Parse.h>
@interface FavoriteRestaurantTableViewController ()

@end

@implementation FavoriteRestaurantTableViewController
{
    NSArray *favoriteRestaurants, *favoriteRestaurantsInfo;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationForKey:@"favorites"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            favoriteRestaurants=objects;
            [self.tableView reloadData];
        }
        else
        {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
            
        }
    }];
    
    //self.tableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    NSLog(@"in view will appear");

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.

    return [favoriteRestaurants count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favorite" forIndexPath:indexPath];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"favorite"] ;
    }
    PFUser *user = [PFUser currentUser];
    NSLog(@"here");
    NSLog(@"name %@",favoriteRestaurants[indexPath.row][@"Name"]);
    cell.textLabel.text=favoriteRestaurants[indexPath.row][@"Name"];
    // Configure the cell...
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"favoriteRestaurantDetail"])
    {
        RestaurantDetailViewController *controller = (RestaurantDetailViewController *)segue.destinationViewController;
        UITableViewCell *cell = (UITableViewCell *)sender;
        controller.name = cell.textLabel.text;
        controller.location= cell.detailTextLabel.text;
        //controller.hours=@"";
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
