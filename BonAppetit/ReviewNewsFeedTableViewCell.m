//
//  ReviewNewsFeedTableViewCell.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/9/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "ReviewNewsFeedTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    //testing
    // Here we use the new provided setImageWithURL: method to load the web image
    [self.reviewImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.networksocal.com/%@", review.filepath]]];
    //testing
    self.reviewImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.reviewImageView.clipsToBounds = YES;
    
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];
    
    self.ratingView.canEdit = NO;
    self.ratingView.maxRating = 5;
    self.ratingView.rating = [review.rating doubleValue];
}


@end
