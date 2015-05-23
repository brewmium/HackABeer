//
//  NSDictionary+brewmium.m
//
//  Created by Eric Hayes on 3/26/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "NSDictionary+brewmium.h"
#import "FFLog.h"

@implementation NSMutableDictionary (brewmium)

#pragma mark - Mutable Dict <-> JSON File

+ (NSMutableDictionary *)readJsonFile:(NSString *)path;
{
	NSDictionary *dict = [NSDictionary readJsonFile:path];
	if ( dict == nil ) return nil;
	
	return [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (BOOL)writeJsonFile:(NSString *)path;
{
	NSError *err;
	NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&err];
	if ( err ) return NO;
	
	return [data writeToFile:path atomically:YES];
}


#pragma mark - Mutable Dict <-> JSON File


- (NSData *)dictionaryToData;
{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}


#pragma mark Way Safer X for Key!!!


- (void)safeSetObject:(id)obj forKey:(id<NSCopying>)key;
{
	if ( obj == nil ) {
		FFLogWarning(@"Just tried to setObject of NIL into a mdict. key='%@'", key);
		return;
	}
	
	[self setObject:obj forKey:key];
}

@end


@implementation NSDictionary (brewmium)


#pragma mark - Dict <-> JSON File


+ (NSDictionary *)readJsonFile:(NSString *)path;
{
	NSData *data = [[NSData alloc] initWithContentsOfFile:path];
	if ( data == nil ) return nil;
	
	return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

- (BOOL)writeJsonFile:(NSString *)path;
{
	NSError *err;
	NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&err];
	if ( err ) return NO;
	
	return [data writeToFile:path atomically:YES];
}

#pragma mark - Data <-> Dict

- (NSData *)dictionaryToData;
{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

+ (NSData *)dictionaryToData:(NSDictionary *)dict;
{
	if ( dict == nil ) return nil;
	
	return [NSKeyedArchiver archivedDataWithRootObject:dict];
}

+ (NSDictionary *)dataToDictionary:(NSData *)data;
{
	if ( data == nil ) return nil;
	
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


#pragma mark Way Safer X for Key!!!


- (NSDictionary *)dictionaryForKey:(id)theKey;
{
	id dict = [self objectForKey:theKey];
	
	if ( [dict isKindOfClass:[NSDictionary class]] ) {
		return dict;
	}
	
	return nil;
}

- (NSArray *)arrayForKey:(id)theKey
{
	id arr = [self objectForKey:theKey];
	
	if ( [arr isKindOfClass:[NSArray class]] ) {
		return arr;
	} else {
		return nil;
	}
}

- (NSString *)stringForKey:(id)theKey
{
	id str = [self objectForKey:theKey];
	
	if ( [str isKindOfClass:[NSString class]] ) {
		return str;
	}
	
	if ( [str isKindOfClass:[NSNumber class]] ) {
		return [str stringValue];
	}
	
	return nil;
}

- (NSNumber *)numberForKey:(id)theKey
{
	id numb = [self objectForKey:theKey];
	
	if ( [numb isKindOfClass:[NSNumber class]] ) {
		return numb;
	}
	
	if ( [numb isKindOfClass:[NSString class]] ) {
		return [NSNumber numberWithInt:[numb intValue]];
	}
	
	return nil;
}

// catch all
- (id)objectForKey:(id)theKey forClass:(Class)theClass
{
	id obj = [self objectForKey:theKey];
	if ( [obj isKindOfClass:theClass] ) {
		return obj;
	} else {
		return nil;
	}
}

// blah, i guess...  i'll never use it  :-p
- (id)valueForKeyPath:(id)theKey forClass:(Class)theClass
{
	id result = nil;
	
	@try {
		result = [self valueForKeyPath:theKey];
	}
	@catch (NSException * theException) {
		FFLogError(@"valueForKeyPath:kindOfClass: FAILED! (%@)", theException);
	}
	
	if ( [result isKindOfClass:theClass] ) {
		return result;
	} else {
		return nil;
	}
}

- (BOOL)keyExists:(id)theKey
{
	return ( [self objectForKey:theKey] != nil );
}

@end