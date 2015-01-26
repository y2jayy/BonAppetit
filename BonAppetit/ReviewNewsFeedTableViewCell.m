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
#import <GoogleMaps/GoogleMaps.h>
//#import <FacebookSDK/FacebookSDK.h>

@interface ReviewNewsFeedTableViewCell ()

//temp
@property (nonatomic, strong) BAUser *user;
//temp
@property (nonatomic, strong) BAReview *review;

@end

@implementation ReviewNewsFeedTableViewCell {
    GMSMapView *mapView_;
//    //testing
//    NSMutableDictionary *places;
//    //testing
}

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

    self.reviewerNameLabel.text = [NSString stringWithFormat:@"%@ %@", review.firstName, review.lastName];
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reviewerNameLabelTapped:)];
    tapGestureRecognizer1.numberOfTapsRequired = 1;
    [self.reviewerNameLabel addGestureRecognizer:tapGestureRecognizer1];
    self.reviewerNameLabel.userInteractionEnabled = YES;
    
    self.restaurantNameLabel.text = review.restaurantName;
    //testing
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.restaurantNameLabel addGestureRecognizer:tapGestureRecognizer];
    self.restaurantNameLabel.userInteractionEnabled = YES;
    //testing
    
NSLog(@"%@", review);
    
    //testing
    // Here we use the new provided setImageWithURL: method to load the web image
    [self.reviewImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.networksocal.com/%@", review.filepath]]];
    //testing
    self.reviewImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.reviewImageView.clipsToBounds = YES;
    
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];

    self.likesCountLabel.text = [NSString stringWithFormat:@" %d likes", review.likesCount];
    
    self.ratingView.canEdit = NO;
    self.ratingView.maxRating = 5;
    self.ratingView.rating = [review.rating doubleValue];
    
    //set latitude and longitude
    self.coordinates = CLLocationCoordinate2DMake(review.latitude, review.latitude);
    //end
}

- (IBAction)didTapLikeButton:(id)sender {
    if (self.likeButton == sender) {
        self.likeButton.enabled = NO;
        self.likesCountLabel.text = [NSString stringWithFormat:@" %d likes", self.review.likesCount+1];
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

- (void)openMap:(id)sender {
    NSError *error;
//    NSDictionary *restaurantData = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error][@"results"][0];
//    
//    double lat = [restaurantData[@"geometry"][@"location"][@"lat"] doubleValue],
//            lng = [restaurantData[@"geometry"][@"location"][@"lng"] doubleValue];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?q=%@&center=%f,%f&zoom=15&views=traffic&x-success=bonappetitapp://?resume=true&x-source=bonappetitapp",   [self.restaurantNameLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], self.coordinates.latitude, self.coordinates.longitude]]];
    } else {
        NSLog(@"Can't use comgooglemaps://");
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
//                                                              longitude:lng
//                                                                   zoom:14];
//        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//        mapView_.myLocationEnabled = YES;
//        self.view = mapView_;
//
//        // Creates a marker in the center of the map.
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake(lat, lng);
//        marker.title = restaurantData[@"name"];
//        marker.snippet = restaurantData[@"vicinity"];
//        marker.map = mapView_;
    }
}

- (void)reviewerNameLabelTapped:(id)sender {
    NSError *error;
//    NSDictionary *restaurantData = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error][@"results"][0];
//    
//    double lat = [restaurantData[@"geometry"][@"location"][@"lat"] doubleValue],
//            lng = [restaurantData[@"geometry"][@"location"][@"lng"] doubleValue];
    UITableView *tv = (UITableView *)self.superview.superview;
    UITableViewController *vc = (UITableViewController *) tv.dataSource;
    [vc performSegueWithIdentifier:@"FoodFeedToUserReviewsSegue" sender:self];
}

@end
