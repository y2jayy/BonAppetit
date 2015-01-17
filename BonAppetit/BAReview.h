//
//  BAReview.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/10/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "BAJSONModel.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class BAUser;

@interface BAReview : BAJSONModel

@property (nonatomic, copy) NSString *reviewId;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *restaurantName;
@property (nonatomic, strong) NSDate *createdAtDate;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *filepath;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
//temp
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
//temp
//testing
@property (nonatomic, copy) NSString *likesCount;
//testing
@property (nonatomic, strong) BAUser *user;

@end
