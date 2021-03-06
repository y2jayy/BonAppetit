//
//  BAReview.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/10/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "BAReview.h"

@implementation BAReview

#pragma mark - JSON Model

+ (JSONKeyMapper*)keyMapper
{
    // Mapping is <JSON key> : <property name>
    // Others are named the same and will be mapped automatically
    NSDictionary *mapperDictionary = @{ @"review_id" : @"reviewId",
                                        @"like_id" : @"likeId",
                                        @"restaurant_name" : @"restaurantName",
                                        @"first_name": @"firstName",
                                        @"last_name": @"lastName",
                                        @"created_at": @"createdAtDate"};
    
    return [[JSONKeyMapper alloc] initWithDictionary:mapperDictionary];
}

@end
