//
//  NSObject+TypeValidation.m
//
//  Created by Jerry Jones on 5/15/12.
//  Copyright (c) 2012 Spaceman Labs, LLC. All rights reserved.
//

#import "NSObject+TypeValidation.h"

BOOL CFTypeIsNull(id object)
{
	return CFNullGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsNumber(id object)
{
	return CFNumberGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsDate(id object)
{
	return CFDateGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsString(id object)
{
	return CFStringGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsDictionary(id object)
{
	return CFDictionaryGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsArray(id object)
{
	return CFArrayGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsBoolean(id object)
{
	return CFBooleanGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

BOOL CFTypeIsData(id object)
{
	return CFDataGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object);
}

@implementation NSObject (TypeValidation)

- (BOOL)isNull
{
	return CFTypeIsNull(self);
}

- (BOOL)isNumber
{
	return CFTypeIsNumber(self);
}

- (BOOL)isDate
{
	return CFTypeIsDate(self);
}

- (BOOL)isString
{
	return CFTypeIsString(self);
}

- (BOOL)isDictionary
{
	return CFTypeIsDictionary(self);
}

- (BOOL)isArray
{
	return CFTypeIsArray(self);
}

- (BOOL)isBoolean
{
	return CFTypeIsBoolean(self);
}

- (BOOL)isData
{
	return CFTypeIsData(self);
}

- (NSNull *)nullOrNilValue
{
	return CFTypeIsNull(self) ? (NSNull *)self : nil;
}

- (NSNumber *)numberOrNilValue
{
	return CFTypeIsNumber(self) ? (NSNumber *)self : nil;
}

- (NSDate *)dateOrNilValue
{
	return CFTypeIsData(self) ? (NSDate *)self : nil;
}

- (NSString *)stringOrNilValue
{
	return CFTypeIsString(self) ? (NSString *)self : nil;
}

- (NSDictionary *)dictionaryOrNilValue
{
	return CFTypeIsDictionary(self) ? (NSDictionary *)self : nil;
}

- (NSArray *)arrayOrNilValue
{
	return CFTypeIsArray(self) ? (NSArray *)self : nil;
}

- (NSData *)dataOrNilValue
{
	return CFTypeIsData(self) ? (NSData *)self : nil;
}


@end
