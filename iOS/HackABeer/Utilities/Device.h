//
//  BrewDevice.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

+ (id)sharedInstance;

+ (BOOL)getIsIPad;
+ (BOOL)getIsIPhone;

+ (BOOL)getIsRetina;
+ (BOOL)getIsZoomedScreen;
+ (BOOL)getIsNarrowPhoneScreen;
+ (BOOL)getIsWidePhoneScreen;
+ (BOOL)getIsShortPhoneScreen;
+ (BOOL)getIsTallPhoneScreen;

+ (BOOL)getIsIPhone4Screen;
+ (BOOL)getIsIPhone5Screen;
+ (BOOL)getIsIPhone6Screen;
+ (BOOL)getIsIPhone6lusScreen;

+ (UIImage *)getSplashImageForSize:(CGSize)inSize;

+ (CGFloat)getScalerForIPad;
+ (CGFloat)getLesserScalerForIPad;
+ (CGAffineTransform)makeStandardIPadScaleTransform;
+ (CGAffineTransform)makeLesserIPadScaleTransform;

@end
