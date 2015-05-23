//
//  RectUtils.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


CG_INLINE CGRect CGRectChangeX(CGRect r, CGFloat x)
{
	CGRect rect = r;
	rect.origin.x = x;
	return rect;
}

CG_INLINE CGRect CGRectChangeY(CGRect r, CGFloat y)
{
	CGRect rect = r;
	rect.origin.y = y;
	return rect;
}

CG_INLINE CGRect CGRectChangeHeight(CGRect r, CGFloat height)
{
	CGRect rect = r;
	rect.size.height = height;
	return rect;
}

CG_INLINE CGRect CGRectChangeWidth(CGRect r, CGFloat width)
{
	CGRect rect = r;
	rect.size.width = width;
	return rect;
}

CG_INLINE CGRect CGRectChangeOrigin(CGRect r, CGPoint origin)
{
	CGRect rect = r;
	rect.origin = origin;
	return rect;
}

CG_INLINE CGRect CGRectChangeSize(CGRect r, CGSize size)
{
	CGRect rect = r;
	rect.size = size;
	return rect;
}


@interface RectUtils : NSObject

+ (CGRect)calcAspectSize:(CGSize)inSize thatFitsInRect:(CGRect)parentRect centered:(BOOL)centered;

+ (CGFloat)calcVertCenterForHeight:(CGFloat)inHeight inRect:(CGRect)parentRect;
+ (CGFloat)calcHorizCenterForWidth:(CGFloat)inWidth inRect:(CGRect)parentRect;

+ (CGFloat)calcVertTopForHeight:(CGFloat)inHeight inRect:(CGRect)parentRect;
+ (CGFloat)calcHorizTopFor:(CGFloat)inWidth inRect:(CGRect)parentRect;

@end
