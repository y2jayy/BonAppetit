//
//  CameraViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import "CameraViewController.h"
#import "ASStarRatingView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AFHTTPRequestOperation.h>
#import <AFHTTPRequestOperationManager.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GoogleMaps/GoogleMaps.h>
#import "SharePhotoViewController.h"

@interface CameraViewController ()

@property (nonatomic, strong) ASStarRatingView *editableStarRatingView;
@property (nonatomic, strong) UIButton *confirmRatingButton;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Device has no camera"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //testing
    [self.editableStarRatingView removeFromSuperview];
    self.editableStarRatingView = [[ASStarRatingView alloc] init];
    self.editableStarRatingView.canEdit = YES;
    self.editableStarRatingView.maxRating = 5;
    self.editableStarRatingView.rating = 3;
    self.editableStarRatingView.frame = CGRectMake(32, 100, 256, 128);
    [self.view addSubview:self.editableStarRatingView];
    //testing
    
    //testing
    [self.confirmRatingButton removeFromSuperview];
    self.confirmRatingButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 80, 40)];
    [self.confirmRatingButton setTitle:@"Next!" forState:UIControlStateNormal];
    [self.confirmRatingButton setBackgroundColor:[UIColor greenColor]];
    [self.confirmRatingButton addTarget:self action:@selector(getRestaurant) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmRatingButton];
    //testing
    
    [self startStandardUpdates];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)getRestaurant {
    [self performSegueWithIdentifier:@"nextButtonSegue" sender:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == _placeSearchConnection)
    {
        // Parse the JSON that came in
        NSError *error;
        NSDictionary *restaurantData = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error][@"results"][0];
        
        double lat = [restaurantData[@"geometry"][@"location"][@"lat"] doubleValue],
                lng = [restaurantData[@"geometry"][@"location"][@"lng"] doubleValue];

//        [self dismissViewControllerAnimated:YES completion:nil];
    //testing
    
    [self.editableStarRatingView removeFromSuperview];
    [self.confirmRatingButton removeFromSuperview];
    self.imageView.image = nil;
    }
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
    {
        // Configure Location Manager
        _locationManager = [[CLLocationManager alloc] init];
 
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
     
        // Set a movement threshold for new events.
        _locationManager.distanceFilter = 0; // meters
    }
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
      didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
        // If the event is recent, do something with it.
        
        // Push your "new" location to the database.
        // This needs to be changed so that the update happens not on a time interval, but on a minimum location change.

        _coordinates.latitude = location.coordinate.latitude;
        _coordinates.longitude = location.coordinate.longitude;
NSLog(@"Latitude: %f", _coordinates.latitude);
        
        // Stop Updating Locations
        [_locationManager stopUpdatingLocation];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"nextButtonSegue"]) {
        SharePhotoViewController *controller = (SharePhotoViewController *)segue.destinationViewController;
        controller.rating = self.editableStarRatingView.rating;
        controller.latitude = self.coordinates.latitude;
        controller.longitude = self.coordinates.longitude;
NSLog(@"It's the segue that's the problem? %@", self.imageView.image);
        controller.photoTaken = self.imageView.image;
    }
}

@end
