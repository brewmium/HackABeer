//
//  NSArray+brewmium.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (brewmium)

- (NSDictionary *)dictionaryAtIndex:(NSInteger)theIndex;
- (NSArray *)arrayAtIndex:(NSInteger)theIndex;
- (NSString *)stringAtIndex:(NSInteger)theIndex;
- (NSNumber *)numberAtIndex:(NSInteger)theIndex;

- (id)objectAtIndex:(NSInteger)theIndex forClass:(Class)theClass;
- (id)safeObjectAtIndex:(NSInteger)theIndex;

- (BOOL)isValidIndex:(NSInteger)theIndex;

@end
