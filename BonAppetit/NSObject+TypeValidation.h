//
//  NSObject+TypeValidation.h
//
//  Created by Jerry Jones on 5/15/12.
//  Copyright (c) 2012 Spaceman Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL CFTypeIsNull(id object);
BOOL CFTypeIsNumber(id object);
BOOL CFTypeIsDate(id object);
BOOL CFTypeIsString(id object);
BOOL CFTypeIsDictionary(id object);
BOOL CFTypeIsArray(id object);
BOOL CFTypeIsBoolean(id object);
BOOL CFTypeIsData(id object);

@interface NSObject (TypeValidation)

- (BOOL)isNull;
- (BOOL)isNumber;
- (BOOL)isDate;
- (BOOL)isString;
- (BOOL)isDictionary;
- (BOOL)isArray;
- (BOOL)isBoolean;
- (BOOL)isData;

- (NSNull *)nullOrNilValue;
- (NSNumber *)numberOrNilValue;
- (NSDate *)dateOrNilValue;
- (NSString *)stringOrNilValue;
- (NSDictionary *)dictionaryOrNilValue;
- (NSArray *)arrayOrNilValue;
- (NSData *)dataOrNilValue;

@end
