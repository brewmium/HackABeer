//
//  NSString+brewmium.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "NSString+brewmium.h"

@implementation NSString (brewmium)

// useful for simulating [textField shouldChangeCharactersInRange:replacementString:] YES results for validating
+ (NSString *)stringByReplacing:(NSString *)sourceString
						  range:(NSRange)range
					 withString:(NSString *)replacementString;
{
	NSMutableString * mstr = nil;
	if ( [sourceString length] == 0  ) {
		mstr = [NSMutableString stringWithString:replacementString];
	} else {
		mstr = [NSMutableString stringWithString:sourceString];
		[mstr replaceCharactersInRange:range withString:replacementString];
	}
	
	return [NSString stringWithString:mstr];
}

+ (NSString *)stringByReplacing:(NSString *)key withValue:(NSString *)inValue inString:(NSString *)inString;
{
	NSMutableString *mstr = [NSMutableString stringWithFormat:@"%@", inString];
	[mstr replaceOccurrencesOfString:key
						  withString:inValue
							 options:NSLiteralSearch
							   range:NSMakeRange(0, [mstr length])];
	return [NSString stringWithFormat:@"%@", mstr];
}

- (BOOL)isValidEmail;
{
	NSString * regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	BOOL result = [test evaluateWithObject:self];
	if ( result == NO ) {
		FFLogVerbose(@"%@ is NOT a valid email address", self);
	}
	
	return result;
}


- (BOOL)isValidPhoneNumber;
{
	NSString * regex = @"^((\\+)|(00))[0-9]{6,14}$";
	NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [test evaluateWithObject:self];
}

- (BOOL)isValidPhonePartial;
{
	BOOL valid = YES;
	
	for (int i = 0 ; i < [self length] ; i++) {
		unichar c = [self characterAtIndex:i];
		if ( !isdigit(c) ) {
			if ( c == '-' || c == '(' || c == ')' ) {
				//these are okay
			} else {
				valid = NO;
				break;
			}
		}
	}
	
	return valid;
}

- (BOOL)isValidPin;
{
	return self.length >= kMinimimPinLength;
}

- (BOOL)isValidPassword;
{
	return  self.length >= kMinimimPasswordLength;
}


@end
