//
//  NSObject+brewmium.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "NSObject+brewmium.h"

@implementation NSObject (brewmium)


- (void)delayedAction:(NSTimeInterval)delay closure:(void (^)(void))closure;
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC),
				   dispatch_get_main_queue(),
				   closure);
}

+ (void)delayedAction:(NSTimeInterval)delay closure:(void (^)(void))closure;
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC),
				   dispatch_get_main_queue(),
				   closure);
}


- (void)refreshAccessibility;
{
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

+ (void)refreshAccessibility;
{
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}


- (void)refreshAccessibilityScreenChanged:(id)optionalStringOrObject;
{
	UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, optionalStringOrObject);
}

+ (void)refreshAccessibilityScreenChanged:(id)optionalStringOrObject;
{
	UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, optionalStringOrObject);
}


@end
