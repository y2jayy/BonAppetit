//
//  UserReviewsCollectionViewCell.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/25/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <GoogleMaps/GoogleMaps.h>
#import "BAReview.h"

@interface UserReviewsCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (strong, nonatomic) IBOutlet ASStarRatingView *staticStarRatingView;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinates;

- (void)configureWithReview:(BAReview *)review;

@end
