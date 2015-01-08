//
//  ASStarRatingView.h
//
//  Created by bl0ckme on 12/19/11.
//  Copyright (c) 2011 bl0ckme. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultMaxRating 5
#define kDefaultLeftMargin 5
#define kDefaultMidMargin 5
#define kDefaultRightMargin 5
#define kDefaultMinAllowedRating 1
#define kDefaultMaxAllowedRating kDefaultMaxRating
#define kDefaultMinStarSize CGSizeMake(5, 5)

@interface ASStarRatingView : UIView {
    NSMutableArray *_starViews;
}

@property (strong, nonatomic) UIImage *notSelectedStar;
@property (strong, nonatomic) UIImage *selectedStar;
@property (strong, nonatomic) UIImage *halfSelectedStar;
@property (assign, nonatomic) BOOL canEdit;
@property (assign, nonatomic) int maxRating;
@property (assign, nonatomic) float leftMargin;
@property (assign, nonatomic) float midMargin;
@property (assign, nonatomic) float rightMargin;
@property (assign, nonatomic) CGSize minStarSize;
@property (assign, nonatomic) float rating;
@property (assign, nonatomic) float minAllowedRating;
@property (assign, nonatomic) float maxAllowedRating;
@end
