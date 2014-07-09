//
//  WhatsOpenTableViewController.m
//  mini-project
//
//  Created by Mengdi Lin on 7/8/14.
//  Copyright (c) 2014 Mengdi Lin. All rights reserved.
//

#import <Parse/Parse.h>
#import "RestaurantsTableViewController.h"
#import "Restaurant.h"
#import "RestaurantStore.h"
#import "RestaurantDetailViewController.h"
@interface RestaurantsTableViewController ()

@end

@implementation RestaurantsTableViewController
{
    NSString *className;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        className=@"Restaurant";
        self.pullToRefreshEnabled=YES;
        self.paginationEnabled=NO;
        self.objectsPerPage=25;
        
    }
    return self;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self addScrollView];
}
-(PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:className];
    if([self.objects count] == 0)
    {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query orderByDescending:@"createdAt"];
    return query;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WhatsOpen"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WhatsOpen"];
    }
    
    cell.textLabel.text=object[@"Name"];
    cell.detailTextLabel.text=object[@"Location"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"RestaurantsToRestaurantDetail" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"RestaurantsToRestaurantDetail"])
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
