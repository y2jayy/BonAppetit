//
//  SharePhotoViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/18/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePhotoViewController : UIViewController

@property (nonatomic) float rating;
@property (nonatomic, copy) NSString *placeName;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, strong) UIImage *photoTaken;

@end
