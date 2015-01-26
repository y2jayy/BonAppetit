//
//  UserReviewsCollectionViewCell.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/25/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "UserReviewsCollectionViewCell.h"

@interface UserReviewsCollectionViewCell ()

@property (nonatomic, strong) BAReview *review;

@end

@implementation UserReviewsCollectionViewCell

- (void)configureWithReview:(BAReview *)review
{
    self.review = review;
    //temp
//    self.user = [[API sharedManager] signedInUser];
    //temp
    
    self.restaurantNameLabel.text = review.restaurantName;
    //testing
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.restaurantNameLabel addGestureRecognizer:tapGestureRecognizer];
    self.restaurantNameLabel.userInteractionEnabled = YES;
    //testing
    
    //testing
    // Here we use the new provided setImageWithURL: method to load the web image
    [self.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.networksocal.com/%@", review.filepath]]];
    //testing
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];

//    self.likesCountLabel.text = [NSString stringWithFormat:@" %d likes", review.likesCount];
    
    self.staticStarRatingView.canEdit = NO;
    self.staticStarRatingView.maxRating = 5;
    self.staticStarRatingView.rating = [review.rating doubleValue];
    
    //set latitude and longitude
    self.coordinates = CLLocationCoordinate2DMake(review.latitude, review.latitude);
    //end
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

@end
