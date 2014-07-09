//
//  AddRestaurantViewController.h
//  mini-project
//
//  Created by Anne Lim on 7/8/14.
//  Copyright (c) 2014 Anne Lim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol AddRestaurantViewControllerDelegate;

@interface AddRestaurantViewController : UIViewController

@property (nonatomic) PFObject *restaurant;

@property (strong, nonatomic) NSDate *openDate;
@property (strong, nonatomic) NSDate *closeDate;
@property (weak, nonatomic) IBOutlet id <AddRestaurantViewControllerDelegate> delegate;

@end

@protocol AddRestaurantViewControllerDelegate <NSObject>

- (void)addViewController:(AddRestaurantViewController *)controller
        didSelectOpenDate:(NSDate *)openDate;

@end