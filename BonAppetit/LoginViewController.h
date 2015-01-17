//
//  LoginViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController <FBLoginViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

// NSURLConnection data and connections
@property NSMutableData* receivedData;
@property (nonatomic, strong) NSURLConnection *authenticateConnection;
@property (nonatomic, strong) NSURLConnection *signupConnection;
// End NSURLConnection data and connections

@end
