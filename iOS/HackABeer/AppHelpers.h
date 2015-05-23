//
//  AppHelpers.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//
//	Various helpers to aid readibliity and typing efficiency
//
//

#define MAIN_QUEUE						[NSOperationQueue mainQueue]

#define kSecondsInAMinute				(60)
#define kSecondsInAnHour				(kSecondsInAMinute * 60)
#define kSecondsInADay					(kSecondsInAnHour * 24)
#define kSecondsInAWeek					(kSecondsInADay * 7)

#define NSAllCalendarUnits				( NSHourCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSSecondCalendarUnit )

#pragma mark - Feature Selectors
#define kTuckUnder					(1)		// if you want to be tucked under the status bar
#define kSupportIPhoneOnly			(1)
#define kDefaultToScalingElements	(1)


// auto-position helpers -- less space + more readable == nice, happy, auto-repositioning values...
//	UIViewAutoresizingNone					/*  0 */	= 0,
//	UIViewAutoresizingFlexibleLeftMargin	/*  1 */	= 1 << 0,
//	UIViewAutoresizingFlexibleWidth			/*  2 */	= 1 << 1,
//	UIViewAutoresizingFlexibleRightMargin	/*  4 */	= 1 << 2,
//	UIViewAutoresizingFlexibleTopMargin		/*  8 */	= 1 << 3,
//	UIViewAutoresizingFlexibleHeight		/* 16 */	= 1 << 4,
//	UIViewAutoresizingFlexibleBottomMargin	/* 32 */	= 1 << 5
#define UIViewAutoresizingCenter			/* 45 */	(UIViewAutoresizingFlexibleTopMargin	| UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin   | UIViewAutoresizingFlexibleRightMargin )
#define UIViewAutoresizingTopCenter			/* 37 */	(UIViewAutoresizingFlexibleLeftMargin	| UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleBottomMargin )
#define UIViewAutoresizingBottomCenter		/* 13 */	(UIViewAutoresizingFlexibleLeftMargin	| UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleTopMargin	  )
#define UIViewAutoresizingCenterRight		/* 41 */	(UIViewAutoresizingFlexibleTopMargin	| UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin	  )
#define UIViewAutoresizingCenterLeft		/* 44 */	(UIViewAutoresizingFlexibleTopMargin	| UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin  )
#define UIViewAutoresizingFill				/* 18 */	(UIViewAutoresizingFlexibleHeight		| UIViewAutoresizingFlexibleWidth		 )
#define UIViewAutoresizingCenterVert		/* 40 */	(UIViewAutoresizingFlexibleTopMargin	| UIViewAutoresizingFlexibleBottomMargin )
#define UIViewAutoresizingCenterHoriz		/*  5 */	(UIViewAutoresizingFlexibleLeftMargin	| UIViewAutoresizingFlexibleRightMargin	 )
#define UIViewAutoresizingTopRight			/* 33 */	(UIViewAutoresizingFlexibleLeftMargin	| UIViewAutoresizingFlexibleBottomMargin )
#define UIViewAutoresizingTopLeft			/* 36 */	(UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleBottomMargin )
#define UIViewAutoresizingTopFill			/* 34 */	(UIViewAutoresizingFlexibleWidth		| UIViewAutoresizingFlexibleBottomMargin )
#define UIViewAutoresizingRightFill			/* 17 */	(UIViewAutoresizingFlexibleHeight		| UIViewAutoresizingFlexibleLeftMargin   )
#define UIViewAutoresizingBottomRight		/*  9 */	(UIViewAutoresizingFlexibleLeftMargin	| UIViewAutoresizingFlexibleTopMargin	 )
#define UIViewAutoresizingBottomLeft		/* 12 */	(UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleTopMargin	 )
#define UIViewAutoresizingBottomFill		/* 10 */	(UIViewAutoresizingFlexibleWidth		| UIViewAutoresizingFlexibleTopMargin	 )

#define kInvalidIndex					(-1)

#define RAND(min,max)					(min + rand() / (RAND_MAX / (max - min + 1.0f) + 1.0f))
#define ORNULL(x)						((x) ? x : [NSNull null])

#define DEG2RAD(x)						(x * M_PI / 180)
#define RAD2DEG(x)						(x * 180 / M_PI)

