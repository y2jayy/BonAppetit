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
    NSDictionary *mapperDictionary = @{ @"id" : @"reviewId",
                                        @"restaurant_name" : @"restaurantName"};
    
    return [[JSONKeyMapper alloc] initWithDictionary:mapperDictionary];
}

@end
