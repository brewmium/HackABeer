//
//  UIView+brewmium.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "UIView+brewmium.h"

@implementation UIView (brewmium)

- (void)flipWithDirection:(UIViewAnimationTransition)direction fromView:(id)fromView toView:(id)toView;
{
	// match up the dest view's frame to the from views
	((UIView *)toView).frame = ((UIView *)fromView).frame;
	
	
	[UIView beginAnimations:@"doflip" context:nil];
	[UIView setAnimationDuration:kDefaultAnimationDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:direction forView:self cache:YES];
	
	[fromView removeFromSuperview];
	[self addSubview:toView];
	
	[UIView commitAnimations];
}

+ (instancetype)initFromXib:(Class)viewClass
{
	id theView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(viewClass) owner:nil options:nil] firstObject];
	
	return theView;
}


- (void)dumpParentHierarchy:(NSString *)text indent:(NSString *)indent;
{
	Class cl = [self class];
	NSString *classDescription = [cl description];
	while ( [cl superclass] )	{
		cl = [cl superclass];
		classDescription = [classDescription stringByAppendingFormat:@":%@", [cl description]];
	}
	
	if ( [text isEqualToString:@""] ) {
		FFLogInfo(@"%@ %@ alpha:%.1f %@ %@", classDescription, NSStringFromCGRect(self.frame), self.alpha, self.hidden ? @"HIDDEN" : @"!hidden", [UIView stringFromAutoresizeMask:self.autoresizingMask]);
	} else {
		FFLogInfo(@"%@ %@ %@ alpha:%.1f %@ %@", text, classDescription, NSStringFromCGRect(self.frame), self.alpha, self.hidden ? @"HIDDEN" : @"!hidden", [UIView stringFromAutoresizeMask:self.autoresizingMask]);
	}
	
	NSString *newIndent = [NSString stringWithFormat:@"  %@", indent];
	NSString *msg = [NSString stringWithFormat:@"%@:", newIndent];
	[self.superview dumpParentHierarchy:msg indent:newIndent];
}


- (void)dumpChildrenHierarchy:(NSString *)text indent:(NSString *)indent;
{
	Class cl = [self class];
	NSString *classDescription = [cl description];
	while ( [cl superclass] )	{
		cl = [cl superclass];
		classDescription = [classDescription stringByAppendingFormat:@":%@", [cl description]];
	}
	
	FFLogInfo(@"%@ %@ %@ alpha:%.1f %@ %@", text, classDescription,
			  NSStringFromCGRect(self.frame), self.alpha, self.hidden ? @"HIDDEN" : @"",
			  [UIView stringFromAutoresizeMask:self.autoresizingMask]);
	
	for (NSUInteger i = 0 ; i < [self.subviews count] ; i++) {
		UIView *subView = [self.subviews objectAtIndex:i];
		NSString *newIndent = [[NSString alloc] initWithFormat:@"  %@", indent];
		NSString *msg = [[NSString alloc] initWithFormat:@"%@%zd:", newIndent, i];
		[subView dumpChildrenHierarchy:msg indent:newIndent];
	}
}

- (void)poParentsHierarchy:(NSString *)text indent:(NSString *)indent;
{
	FFLogInfo(@"%@:%@", text.length == 0 ? @"parents: " : text, [self description]);
	
	NSString *newIndent = [NSString stringWithFormat:@"  %@", indent];
	NSString *msg = [NSString stringWithFormat:@"%@:", newIndent];
	[self.superview poParentsHierarchy:msg indent:newIndent];
}

- (void)poChildrenHierarchy:(NSString *)text indent:(NSString *)indent;
{
	FFLogInfo(@"%@:%@", text.length == 0 ? @"children: " : text, [self description]);
	
	for (NSUInteger i = 0 ; i < [self.subviews count] ; i++) {
		UIView *subView = [self.subviews objectAtIndex:i];
		NSString *newIndent = [[NSString alloc] initWithFormat:@"  %@", indent];
		NSString *msg = [[NSString alloc] initWithFormat:@"%@%zd:", newIndent, i];
		[subView poChildrenHierarchy:msg indent:newIndent];
	}
}

+ (NSString *)stringFromAutoresizeMask:(NSUInteger)autoresizeMask
{
	NSString *result = @"";
	
	if( autoresizeMask == UIViewAutoresizingNone )							result = @"None";
	if( (autoresizeMask & UIViewAutoresizingFlexibleLeftMargin)		> 0 )	result = [NSString stringWithFormat:@"%@%@%@", result, result.length > 0 ? @"|" : @"", @"FlexLeft"];
	if( (autoresizeMask & UIViewAutoresizingFlexibleWidth)			> 0 )	result = [NSString stringWithFormat:@"%@%@%@", result, result.length > 0 ? @"|" : @"", @"FlexWidth"];
	if( (autoresizeMask & UIViewAutoresizingFlexibleRightMargin)	> 0 )	result = [NSString stringWithFormat:@"%@%@%@", result, result.length > 0 ? @"|" : @"", @"FlexRight"];
	if( (autoresizeMask & UIViewAutoresizingFlexibleTopMargin)		> 0 )	result = [NSString stringWithFormat:@"%@%@%@", result, result.length > 0 ? @"|" : @"", @"FlexibleTop"];
	if( (autoresizeMask & UIViewAutoresizingFlexibleHeight)			> 0 )	result = [NSString stringWithFormat:@"%@%@%@", result, result.length > 0 ? @"|" : @"", @"FlexHeight"];
	if( (autoresizeMask & UIViewAutoresizingFlexibleBottomMargin)	> 0 )	result = [NSString stringWithFormat:@"%@%@%@", result, result.length > 0 ? @"|" : @"", @"FlexBottom"];

	return [NSString stringWithFormat:@"AutoResize=%@", result];
}

@end
