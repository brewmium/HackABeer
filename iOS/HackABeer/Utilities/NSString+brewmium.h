//
//  NSString+brewmium.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (brewmium)

#define kMinimimPasswordLength		(5)
#define kMinimimPinLength			(4)

+ (NSString *)stringByReplacing:(NSString *)sourceString
						  range:(NSRange)range
					 withString:(NSString *)replacementString;

+ (NSString *)stringByReplacing:(NSString *)key
					   withValue:(NSString *)inValue inString:(NSString *)inString;

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;
- (BOOL)isValidPhonePartial;
- (BOOL)isValidPin;
- (BOOL)isValidPassword;

@end
