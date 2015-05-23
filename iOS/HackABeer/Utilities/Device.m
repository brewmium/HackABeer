//
//  BrewDevice.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "Device.h"

@interface Device () {
    BOOL isRetina;
    BOOL isZoomedScreen;    // for the 6 and 6+ screens,
    
    BOOL is4Screen;         // 4
    BOOL is5Screen;         // 5 or 6 zoomed
    BOOL is6Screen;         // 6 or 6+ zoomed
    BOOL is6PlusScreen;     // 6+
}

@end


@implementation Device

+ (id)sharedInstance;
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
		FFLogInfo(@"path: %@", [NSBundle mainBundle].bundlePath);
		[sharedInstance setup];
    });
    
    return sharedInstance;
}

- (void)setup
{
    if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 ){
        isRetina = YES;
    } else {
        isRetina = NO;
    }
    
    // prime the screen size
    
    CGRect r = [UIScreen mainScreen].bounds;
    CGFloat s = [[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)] ? [[UIScreen mainScreen] nativeScale] : 2.0;
    NSInteger biggest = r.size.width > r.size.height ? r.size.width : r.size.height;
    NSInteger smallest = r.size.width < r.size.height ? r.size.width : r.size.height;
    NSInteger scale = s * 100;
    
    if ( smallest == 320 ) {
        if ( scale == 200 ) {
            // 3.5 or 4 inch phone
            is5Screen =  ( biggest > 500 ) ? YES : NO;
            is4Screen = !is5Screen;
        } else if ( scale == 234) {
            // iPhone6 zoomed
            isZoomedScreen = YES;
            is6Screen = YES;
        }
    } else if ( smallest == 375 ) {
        if ( scale == 288 ) {
            // iPhone6+ Zoomed
            isZoomedScreen = YES;
            is6PlusScreen = YES;
        } else if ( scale == 200 ) {
            // iPhone6 Not Zoomed
            is6Screen = YES;
        }
    } else if ( smallest == 414 ) {
        // iPhone6+ Not Zoomed
        is6PlusScreen = YES;
    }
}


#pragma mark - Internals


- (BOOL)_getIsRetina
{
    return isRetina;
}

- (BOOL)_getIsZoomedScreen
{
    return isZoomedScreen;
}

- (BOOL)_getIs4Screen
{
    return is4Screen;
}

- (BOOL)_getIs5Screen
{
    return is5Screen;
}

- (BOOL)_getIs6Screen
{
    return is6Screen;
}

- (BOOL)_getIs6PlusScreen
{
    return is6PlusScreen;
}



#pragma mark - Device Type


+ (BOOL)getIsIPad;
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)getIsIPhone;
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}


#pragma mark - Device Attributes


+ (BOOL)getIsRetina;
{
    return [[Device sharedInstance] _getIsRetina];
}

+ (BOOL)getIsZoomedScreen;
{
    return [[Device sharedInstance] _getIsZoomedScreen];
}

+ (BOOL)getIsNarrowPhoneScreen;
{
	return [[Device sharedInstance] _getIs4Screen] | [[Device sharedInstance] _getIs5Screen];
}

+ (BOOL)getIsWidePhoneScreen;
{
	return ![Device getIsNarrowPhoneScreen];
}

+ (BOOL)getIsShortPhoneScreen;
{
	return [[Device sharedInstance] _getIs4Screen];
}

+ (BOOL)getIsTallPhoneScreen;
{
	return ![Device getIsShortPhoneScreen];
}

#pragma mark - Screen Size


+ (BOOL)getIsIPhone4Screen;
{
    return [[Device sharedInstance] _getIs4Screen];
}

+ (BOOL)getIsIPhone5Screen;
{
    return [[Device sharedInstance] _getIs5Screen];
}

+ (BOOL)getIsIPhone6Screen;
{
    return [[Device sharedInstance] _getIs6Screen];
}

+ (BOOL)getIsIPhone6lusScreen;
{
    return [[Device sharedInstance] _getIs6PlusScreen];
}


#pragma mark - Device Specific Helpers


+ (UIImage *)getSplashImageForSize:(CGSize)inSize;
{
	Device *prd = [Device sharedInstance];
	UIImage *img;
//	CGRect screen = [[UIScreen mainScreen]bounds];
	
	if ( [prd _getIs4Screen] ) {
		img = [UIImage imageNamed:@"Default.png"];
		
	} else if ( [prd _getIs5Screen] ) {
		img = [UIImage imageNamed:@"Default-568h.png"];
		
	} else if ( [prd _getIs6Screen] ) {
		img = [UIImage imageNamed:@"Default-568h.png"];
		
	} else if ( [prd _getIs6PlusScreen] ) {
		img = [UIImage imageNamed:@"Default-568h.png"];
		
	} else if ( [Device getIsIPad] ) {
		img = [UIImage imageNamed:@"Default768x1024.png"];
		
	} else {
		// hmm... just get a big one to scale then
		img = [UIImage imageNamed:@"Default768x1024.png"];
		
	}
	
	if ( CGSizeEqualToSize(img.size, inSize) ) {
		return img;
	} else {
		UIImage *scaledImg;
		UIGraphicsBeginImageContextWithOptions(inSize, NO, 0.f);
		[img drawInRect:CGRectMake(0, 0, inSize.width, inSize.height)];
		scaledImg = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return scaledImg;
	}
}

+ (CGFloat)getScalerForIPad;
{
	return 1.5f;
}

+ (CGFloat)getLesserScalerForIPad;
{
	return 1.25f;
}

+ (CGAffineTransform)makeStandardIPadScaleTransform;
{
	return CGAffineTransformMakeScale([Device getScalerForIPad], [Device getScalerForIPad]);
}

+ (CGAffineTransform)makeLesserIPadScaleTransform;
{
	return CGAffineTransformMakeScale([Device getLesserScalerForIPad], [Device getLesserScalerForIPad]);
}

@end
