//
//  CameraViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinates;

// NSURLConnection data and connections
@property NSMutableData* receivedData;
@property (nonatomic, strong) NSURLConnection *placeSearchConnection;
// End NSURLConnection data and connections

- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;


@end
