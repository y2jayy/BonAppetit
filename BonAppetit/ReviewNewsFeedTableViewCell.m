//
//  ReviewNewsFeedTableViewCell.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/9/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "ReviewNewsFeedTableViewCell.h"

@implementation ReviewNewsFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithReview:(BAReview *)review
{
    self.reviewerNameLabel.text = review.username;
    self.restaurantNameLabel.text = review.restaurantName;
    
    NSURL *url = [NSURL URLWithString:
    [NSString stringWithFormat:@"http://www.networksocal.com/%@", review.filepath]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    self.reviewImageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    self.reviewImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.reviewImageView.clipsToBounds = YES;
    
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];
    
    self.ratingView.canEdit = NO;
    self.ratingView.maxRating = 5;
    self.ratingView.rating = [review.rating doubleValue];
}


@end
