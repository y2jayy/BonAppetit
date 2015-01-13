//
//  BAUser.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/10/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "BAJSONModel.h"
#import <Foundation/Foundation.h>

@interface BAUser : BAJSONModel

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDate *createdAtDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *deviceToken;

@end
