//
//  SharePhotoViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/18/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "SharePhotoViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AFHTTPRequestOperation.h>
#import <AFHTTPRequestOperationManager.h>
#import "PlacesSearchTableViewController.h"

@interface SharePhotoViewController ()

@property (strong, nonatomic) IBOutlet UITextField *selectedPlaceNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *photoTakenImageView;
@end

@implementation SharePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedPlaceNameLabel.text = self.placeName;
    [self.photoTakenImageView setImage:self.photoTaken];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapShareButton:(id)sender {
    AudioServicesPlaySystemSound(1001);
    
    //testing
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.networksocal.com/"]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData *imageData = UIImageJPEGRepresentation(self.photoTakenImageView.image, 0.5);
    
    NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSDictionary *parameters = @{
        @"filepath": [NSString stringWithFormat:@"uploads/%@.jpg", timestamp],
        @"rating": [NSString stringWithFormat:@"%f", self.rating],
        @"restaurantName": self.placeName,
        @"userId": [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"],
        @"latitude": [NSString stringWithFormat:@"%f", self.latitude],
        @"longitude": [NSString stringWithFormat:@"%f", self.longitude],
        @"createdAt": timestamp
    };
    AFHTTPRequestOperation *op = [manager POST:@"?c=review&m=createReview" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg", timestamp] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
   }];
    [op start];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"placeSearchSegue"]) {
        PlacesSearchTableViewController *controller = (PlacesSearchTableViewController *)segue.destinationViewController;
        controller.rating = self.rating;
        controller.latitude = self.latitude;
        controller.longitude = self.longitude;
        controller.photoTaken = self.photoTaken;
    }
}

@end
