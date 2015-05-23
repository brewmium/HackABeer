//
//  NSObject+brewmium.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (brewmium)

- (void)delayedAction:(NSTimeInterval)delay closure:(void (^)(void))closure;
+ (void)delayedAction:(NSTimeInterval)delay closure:(void (^)(void))closure;

- (void)refreshAccessibility;
+ (void)refreshAccessibility;

- (void)refreshAccessibilityScreenChanged:(id)optionalStringOrObject;
+ (void)refreshAccessibilityScreenChanged:(id)optionalStringOrObject;

@end
