//
//  ReviewNewsFeedTableViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/9/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewNewsFeedTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *profileImages;
@property (nonatomic, strong) NSArray *reviewImages;
@property (nonatomic, strong) NSArray *reviewerNames;
@property (nonatomic, strong) NSArray *restaurantNames;
@property (nonatomic, strong) NSArray *ratings;

@end
