//
//  PlacesSearchTableViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/18/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesSearchTableViewController : UITableViewController <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSArray *placeNames;
@property (nonatomic, strong) NSArray *placeAddresses;

// NSURLConnection data and connections
@property NSMutableData* receivedData;
@property (nonatomic, strong) NSURLConnection *placeSearchConnection;
// End NSURLConnection data and connections

@end
