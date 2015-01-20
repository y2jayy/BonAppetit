//
//  BAPlace.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/18/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "BAJSONModel.h"
#import <Foundation/Foundation.h>

@interface BAPlace : BAJSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;

@end
