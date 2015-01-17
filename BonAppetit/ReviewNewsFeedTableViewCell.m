//
//  ReviewNewsFeedTableViewCell.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/9/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "API.h"
#import "ReviewNewsFeedTableViewCell.h"
//#import "ReviewNewsFeedTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ReviewNewsFeedTableViewCell ()

//temp
@property (nonatomic, strong) BAUser *user;
//temp
@property (nonatomic, strong) BAReview *review;

@end

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
    self.review = review;
    //temp
    self.user = [[API sharedManager] signedInUser];
    //temp

    self.reviewerNameLabel.text = review.username;
    self.restaurantNameLabel.text = review.restaurantName;
    //testing
    // Here we use the new provided setImageWithURL: method to load the web image
    [self.reviewImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.networksocal.com/%@", review.filepath]]];
    //testing
    self.reviewImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.reviewImageView.clipsToBounds = YES;
    
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];

    self.likesCountLabel.text = [NSString stringWithFormat:@" %lu", (unsigned long)review.likesCount];
    
    self.ratingView.canEdit = NO;
    self.ratingView.maxRating = 5;
    self.ratingView.rating = [review.rating doubleValue];
}

- (IBAction)didTapLikeButton:(id)sender {
    if (self.likeButton == sender) {
        self.likeButton.enabled = NO;
        self.likesCountLabel.text = [NSString stringWithFormat:@" %lu likes", (unsigned long)self.review.likesCount+1];
    }
    
    [[API sharedManager] addLike:self.user review:self.review.reviewId callback:
     ^(NSDictionary *jsonDictionary, NSError *error) {
         if (error) {
             NSLog(@"Error: %@", error);
         }
         
         //!!!: Implement syncUI or something like that to update buttons
//         [self reloadAsset];
     }];
    
//    [[API sharedManager] sendPushNotification:@"voter" followee:self.asset.couple.coupleId callback:
//     ^(NSError *error) {
//         if (error) {
//             NSLog(@"Error: %@", error);
//         }
//         //         NSLog(@"Acknowledged: %@", follow.acknowledged ? @"YES" : @"NO");
//     }];
}

@end
