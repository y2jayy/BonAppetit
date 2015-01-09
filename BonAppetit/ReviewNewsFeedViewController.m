//
//  ReviewNewsFeedViewController.m
//  StrechyParallaxScrollView
//
//  Created by Cem Olcay on 12/09/14.
//  Copyright (c) 2014 questa. All rights reserved.
//

#import "ReviewNewsFeedViewController.h"
#import "Masonry/Masonry.h"
#import "StrechyParallaxScrollView.h"
#import "ASStarRatingView.h"
//#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface ReviewNewsFeedViewController ()

@end

@implementation ReviewNewsFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //top view
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 150)];
    [topView setImage:[UIImage imageNamed:@"bg.jpg"]];
    [topView setBackgroundColor:RGBCOLOR(128, 26, 26)];
    
    UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [circle setImage:[UIImage imageNamed:@"profile.jpg"]];
    [circle setCenter:topView.center];
    [circle.layer setMasksToBounds:YES];
    [circle.layer setCornerRadius:40];
    [topView addSubview:circle];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, width, 20)];
    [label setText:@"Bon Appetit"];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [topView addSubview:label];

    
    //masonary constraints for parallax view subviews (optional)
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (circle.mas_bottom).offset (10);
        make.centerX.equalTo (topView);
    }];
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo ([NSValue valueWithCGSize:CGSizeMake(80, 80)]);
        make.center.equalTo (topView);
    }];
    
    
    //create strechy parallax scroll view
    StrechyParallaxScrollView *strechy = [[StrechyParallaxScrollView alloc] initWithFrame:self.view.frame andTopView:topView];
    [self.view addSubview:strechy];
    
    //add dummy scroll view items
    float itemStartY = topView.frame.size.height + 10;
    for (int i = 1; i <= 10; i++) {
        [strechy addSubview:[self scrollViewItemWithY:itemStartY andNumber:i]];
        itemStartY += 360;
    }
    
    //set scrollable area (classic uiscrollview stuff)
    [strechy setContentSize:CGSizeMake(width, itemStartY)];
}

- (UIView *)scrollViewItemWithY:(CGFloat)y andNumber:(int)num {
    UIView *item = [[UIView alloc] initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width-20, 350)];
    [item setBackgroundColor:[self randomColor]];
    
    UIImageView *reviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(item.superview.bounds.origin.x + 10, item.superview.bounds.origin.y + 10, item.bounds.size.width - 20, item.bounds.size.width - 20)];
    [reviewImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"food%d.jpg", num]]];
    
    // create a mask that the covers the image exactly
    UIControl *mask = [[UIControl alloc] initWithFrame:reviewImageView.frame];

    // add the image as a subview of this mask
    CGSize imageSize = reviewImageView.frame.size;
    reviewImageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    [mask addSubview:reviewImageView];

    // add a target-action for the desired control events to this mask
    [mask addTarget:self action:@selector(openMap) forControlEvents:UIControlEventTouchUpInside];

    // add the mask as a subview instead of the image
    [item addSubview:mask];
    
    //testing
    ASStarRatingView *staticStarRatingView = [[ASStarRatingView alloc] initWithFrame:CGRectMake(item.superview.bounds.origin.x + 10, item.bounds.origin.y + 250, item.bounds.size.width - 20, (item.bounds.size.width - 20) / 2)];
    staticStarRatingView.canEdit = NO;
    staticStarRatingView.maxRating = 5;
    staticStarRatingView.rating = [self randomRating];
    //testing
    
//    [item addSubview:reviewImageView];
//    [item bringSubviewToFront:reviewImageView];
    
    //testing
    [item addSubview:staticStarRatingView];
    [item bringSubviewToFront:staticStarRatingView];
    //testing
    
//    [item setText:[NSString stringWithFormat:@"Item %d", num]];
//    [item setTextAlignment:NSTextAlignmentCenter];
//    [item setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:26]];
//    [item setTextColor:[UIColor whiteColor]];
    return item;
}

//- (UIView *)scrollViewItemWithY:(CGFloat)y andNumber:(int)num {
//    UIView *item = [[UIView alloc] initWithFrame:CGRectMake(5, y, [UIScreen mainScreen].bounds.size.width-10, 185)];
//    UIImageView *reviewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(item.frame.origin.x + 5, y + 5, item.frame.size.height - 10, item.frame.size.width - 10)];
//    [reviewImageView setImage:[UIImage imageNamed:@"page4.png"]];
//    [reviewImageView setContentMode:UIViewContentModeScaleAspectFit];
//    [item addSubview:reviewImageView];
//    
//    [item setBackgroundColor:[self randomColor]];
////    [item setText:[NSString stringWithFormat:@"Item %d", num]];
////    [item setTextAlignment:NSTextAlignmentCenter];
////    [item setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:26]];
////    [item setTextColor:[UIColor whiteColor]];
//    return item;
//}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (int)randomRating {
    int rating = ( arc4random() % 5 + 1 );  //  0.0 to 1.0
    return rating;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openMap {
   // Create an MKMapItem to pass to the Maps app
    CLLocationCoordinate2D coordinate = 
                CLLocationCoordinate2DMake(16.775, -3.009);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate 
                                            addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:@"My Place"];
    // Pass the map item to the Maps app
    [mapItem openInMapsWithLaunchOptions:nil];
}

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net