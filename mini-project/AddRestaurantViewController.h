//
//  AddRestaurantViewController.h
//  mini-project
//
//  Created by Anne Lim on 7/8/14.
//  Copyright (c) 2014 Anne Lim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddRestaurantViewController : UIViewController

@property (nonatomic) PFObject *restaurant;

-(double)openTime;
-(double)closeTime;

@end
