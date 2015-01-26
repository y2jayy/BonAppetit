//
//  UserReviewsCollectionViewController.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/25/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReviewsCollectionViewCell.h"

@interface UserReviewsCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSString *userId;

@end
