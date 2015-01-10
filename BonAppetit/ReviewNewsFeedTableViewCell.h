//
//  ReviewNewsFeedTableViewCell.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/9/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface ReviewNewsFeedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UIImageView *reviewImageView;
@property (strong, nonatomic) IBOutlet UILabel *reviewerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (strong, nonatomic) IBOutlet ASStarRatingView *ratingView;

@end
