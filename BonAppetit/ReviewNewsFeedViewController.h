//
//  ReviewNewsFeedViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewNewsFeedViewController : UIViewController <NSURLConnectionDataDelegate>

// NSURLConnection data and connections
@property NSMutableData* receivedData;
@property (nonatomic, strong) NSURLConnection *placeSearchConnection;
// End NSURLConnection data and connections

@end
