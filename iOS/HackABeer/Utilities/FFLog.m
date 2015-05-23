//
//  FFLog.m
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import "FFLog.h"


static FFLogLevel _runtimeLevel = FFLogCompiledLevel;


@interface FFLog()

+ _logLevelToString:(FFLogLevel)level;

@end


@implementation FFLog

+ (void)setLogLevel:(FFLogLevel)newLevel;
{
	_runtimeLevel = newLevel;
}

+ (FFLogLevel)getLogLevel;
{
	return _runtimeLevel;
}

+ _logLevelToString:(FFLogLevel)level
{
	switch ( level ) {
		case FFLogLevel_bluetooth:	return @"BLUETOOTH";
		case FFLogLevel_api:		return @"NETWORKAPI";
		case FFLogLevel_error:		return @"ERROR";
		case FFLogLevel_warning:	return @"WARNING";
		case FFLogLevel_info:		return @"INFO";
		case FFLogLevel_verbose:	return @"VERBOSE";
		default:					return @"???";
	}
}

+ (void)log:(NSString *)str level:(FFLogLevel)level;
{
	if ( level == FFLogLevel_bluetooth ) {
		NSLog(@"[%@] %@", [FFLog _logLevelToString:level], str);
		
	} else if ( level == FFLogLevel_api ) {
		NSLog(@"[%@] %@", [FFLog _logLevelToString:level], str);
		
	} else if ( level <= _runtimeLevel ) {
		if ( level == FFLogLevel_warning ) {
			int x = x = 1;	// break on warning. :)
		}
		if ( level == FFLogLevel_error ) {
			int x = x = 1;	// break on error. :)
		}
		NSLog(@"[%@] %@", [FFLog _logLevelToString:level], str);
	}
}


@end
