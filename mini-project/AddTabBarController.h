//
//  AddTabBarController.h
//  mini-project
//
//  Created by Anne Lim on 7/8/14.
//  Copyright (c) 2014 Anne Lim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol AddTabBarViewControllerDelegate;

@interface AddTabBarController : UITabBarController

@property (nonatomic) PFObject *restaurant;
@property (weak, nonatomic) id <AddTabBarViewControllerDelegate> addTabBarDelegate;

@end

@protocol AddTabBarViewControllerDelegate <NSObject>

- (void)addTabBarViewController:(AddTabBarController *)controller
              didSelectOpenDate:(NSDate *)openDate
                            day:(NSString *)dayAsString;

@end