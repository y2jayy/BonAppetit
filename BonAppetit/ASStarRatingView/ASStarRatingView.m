//
//  ASRatingView.m
//  AppShike
//
//  Created by bl0ck on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ASStarRatingView.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation ASStarRatingView

- (void)refreshStars {
    for(int i = 0; i < _starViews.count; ++i) {
        UIImageView *imageView = [_starViews objectAtIndex:i];
        if (_rating >= i+1) {
            imageView.image = _selectedStar;
            _starStates[i] = [NSNumber numberWithBool:YES];
        } else if (_rating > i) {
            imageView.image = _halfSelectedStar;
        } else {
            imageView.image = _notSelectedStar;
            _starStates[i] = [NSNumber numberWithBool:NO];
        }
    }
    
//NSLog(@"%@, %@", _starStates, _starStatesPrev);
//    if (![_starStates isEqualToArray:_starStatesPrev]) {
//        AudioServicesPlaySystemSound(1104);
//    }
//    
//    _starStatesPrev = _starStates;
}

- (void)setupView {
    for(int i = 0; i < _maxRating; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_starViews addObject:imageView];
        [self addSubview:imageView];
    }
    [self refreshStars];
}

- (void)baseInit {
    _notSelectedStar = [UIImage imageNamed:@"not_selected_star"];
    _selectedStar = [UIImage imageNamed:@"selected_star"];
    _halfSelectedStar = [UIImage imageNamed:@"half_selected_star"];
    _starViews = [NSMutableArray array];
    //testing
    _starStates = [NSMutableArray array];
    _starStatesPrev = [NSMutableArray array];
    //testing
    _maxRating = kDefaultMaxRating;
    _midMargin = kDefaultMidMargin;
    _leftMargin = kDefaultLeftMargin;
    _rightMargin = kDefaultRightMargin;
    _minStarSize = kDefaultMinStarSize;
    _minAllowedRating = kDefaultMinAllowedRating;
    _maxAllowedRating = kDefaultMaxAllowedRating;
    _rating = _minAllowedRating;
    _canEdit = YES;
    [self setupView];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];        
    }
    return self;
}

//- (void)dealloc {
//    [_notSelectedStar release];
//    _notSelectedStar = nil;
//    [_selectedStar release];
//    _selectedStar = nil;
//    [_halfSelectedStar release];
//    _halfSelectedStar = nil;
//    [_starViews release];
//    _starViews = nil;
//    [super dealloc];
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSLog(@"%f, %f, %f, %d", self.frame.size.width, _leftMargin, _midMargin, _starViews.count);
    float desiredImageWidth = (self.frame.size.width - (_leftMargin*2) - (_midMargin*_starViews.count)) / _starViews.count;
    float imageWidth = MAX(_minStarSize.width, desiredImageWidth);
    float imageHeight = MAX(_minStarSize.height, self.frame.size.height);
    
    for (int i = 0; i < _starViews.count; ++i) {
        
        UIImageView *imageView = [_starViews objectAtIndex:i];
        CGRect imageFrame = CGRectMake(_leftMargin + i*(_midMargin+imageWidth), 0, imageWidth, imageHeight);
        imageView.frame = imageFrame;
        
    }    
    
}

- (void)setMaxRating:(int)maxRating {
    if (_maxAllowedRating == _maxRating) {
        _maxAllowedRating = maxRating;
    }
    _maxRating = maxRating;
    
    
    // Remove old image views
    for(int i = 0; i < _starViews.count; ++i) {
        UIImageView *imageView = (UIImageView *) [_starViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [_starViews removeAllObjects];
    
    // Add new image views
    [self setupView];    
    // Relayout and refresh
    [self setNeedsLayout];
    [self refreshStars];
}

- (void)setRating:(float)rating {
    _rating = rating;
    [self refreshStars];
}

#pragma mark - Touch Detection

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    if (!_canEdit) return;
    
    _rating = 0;
    for(int i = _starViews.count - 1; i >= 0; i--) {
        UIImageView *imageView = [_starViews objectAtIndex:i];        
        if (touchLocation.x > imageView.frame.origin.x) {
            _rating = i+1;
            break;
        }
    }
    _rating = MAX(_minAllowedRating, _rating);
    _rating = MIN(_maxAllowedRating, _rating);
    [self refreshStars];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


@end
