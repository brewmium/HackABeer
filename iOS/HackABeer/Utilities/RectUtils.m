//
//  RectUtils.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "RectUtils.h"

@implementation RectUtils


+ (CGRect)calcAspectSize:(CGSize)inSize thatFitsInRect:(CGRect)parentRect centered:(BOOL)centered;
{
	CGFloat yRatio = parentRect.size.height / inSize.height;
	CGFloat xRatio = parentRect.size.width / inSize.width;
	CGFloat ratio = fminf(yRatio, xRatio);
	
	// make it the right size
	CGRect result = CGRectMake(0, 0, inSize.width * ratio, inSize.height * ratio);
	
	// nudge it to be centered (much simpler to read when done in 2 steps.v :-)
	if ( centered ) {
		result = CGRectOffset(result,(parentRect.size.width - result.size.width) / 2,
									 (parentRect.size.height - result.size.height) / 2);
	}
	
	return result;
}

+ (CGFloat)calcVertCenterForHeight:(CGFloat)inHeight inRect:(CGRect)parentRect;
{
	return parentRect.origin.y + ((parentRect.size.height/2) - (inHeight/2));
}

+ (CGFloat)calcHorizCenterForWidth:(CGFloat)inWidth inRect:(CGRect)parentRect;
{
	return parentRect.origin.x + ((parentRect.size.width/2) - (inWidth/2));
}

+ (CGFloat)calcVertTopForHeight:(CGFloat)inHeight inRect:(CGRect)parentRect;
{
	return (parentRect.size.height/2) - (inHeight/2);
}

+ (CGFloat)calcHorizTopFor:(CGFloat)inWidth inRect:(CGRect)parentRect;
{
	return (parentRect.size.width/2) - (inWidth/2);
}


@end
