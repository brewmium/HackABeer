//
//  NSDictionary+brewmium.h
//
//  Created by Eric Hayes on 3/26/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableDictionary (brewmium)

+ (NSMutableDictionary *)readJsonFile:(NSString *)path;
- (BOOL)writeJsonFile:(NSString *)path;

- (NSData *)dictionaryToData;

- (void)safeSetObject:(id)obj forKey:(id<NSCopying>)key;

@end


@interface NSDictionary (brewmium)

+ (NSDictionary *)readJsonFile:(NSString *)path;
- (BOOL)writeJsonFile:(NSString *)path;

- (NSData *)dictionaryToData;
+ (NSData *)dictionaryToData:(NSDictionary *)dict;
+ (NSDictionary *)dataToDictionary:(NSData *)data;

- (NSDictionary *)dictionaryForKey:(id)theKey;
- (NSArray *)arrayForKey:(id)theKey;
- (NSString *)stringForKey:(id)theKey;
- (NSNumber *)numberForKey:(id)theKey;

- (id)objectForKey:(id)theKey forClass:(Class)theClass;
- (id)valueForKeyPath:(id)theKey forClass:(Class)theClass;

- (BOOL)keyExists:(id)theKey;

@end