//
//  NSArray+brewmium.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "NSArray+brewmium.h"

@implementation NSArray (brewmium)


#pragma mark - Way Safer X at Index!!!


- (NSDictionary *)dictionaryAtIndex:(NSInteger)theIndex
{
	if ( [self isValidIndex:theIndex] ) {
		id dict = [self objectAtIndex:theIndex];
		if ( [dict isKindOfClass:[NSArray class]] ) {
			return dict;
		}
	}
	
	return nil;
}

- (NSArray *)arrayAtIndex:(NSInteger)theIndex
{
	if ( [self isValidIndex:theIndex] ) {
		id arr = [self objectAtIndex:theIndex];
		if ( [arr isKindOfClass:[NSArray class]] ) {
			return arr;
		}
	}
	
	return nil;
}

- (NSString *)stringAtIndex:(NSInteger)theIndex
{
	if ( [self isValidIndex:theIndex] ) {
		id str = [self objectAtIndex:theIndex];
		if ( [str isKindOfClass:[NSString class]] ) {
			return str;
		}
		
		if ( [str isKindOfClass:[NSNumber class]] ) {
			return [str stringValue];
		}
	}
	
	return nil;
}

- (NSNumber *)numberAtIndex:(NSInteger)theIndex
{
	if ( [self isValidIndex:theIndex] ) {
		id numb = [self objectAtIndex:theIndex];
		
		if ( [numb isKindOfClass:[NSNumber class]] ) {
			return numb;
		}
		
		if ( [numb isKindOfClass:[NSString class]] ) {
			return [NSNumber numberWithInt:[numb intValue]];
		}
	}
	
	return nil;
}

- (id)objectAtIndex:(NSInteger)theIndex forClass:(Class)theClass
{
	if ( [self isValidIndex:theIndex] ) {
		id obj = [self objectAtIndex:theIndex];
		if ( [obj isKindOfClass:theClass] ) {
			return obj;
		}
	}
	
	return nil;
}

- (id)safeObjectAtIndex:(NSInteger)theIndex
{
	if ( [self isValidIndex:theIndex] ) {
		return [self objectAtIndex:theIndex];
	}
	return nil;
}

- (BOOL)isValidIndex:(NSInteger)theIndex
{
	return (theIndex >= 0 && theIndex < [self count]);
}

@end
