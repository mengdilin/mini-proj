//
//  RestaurantDetailViewController.h
//  mini-project
//
//  Created by Mengdi Lin on 7/8/14.
//  Copyright (c) 2014 Mengdi Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
@interface RestaurantDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSArray *hours;
@end
