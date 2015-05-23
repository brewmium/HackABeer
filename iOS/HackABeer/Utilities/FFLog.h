//
//  FFLog.h
//
//  Created by Eric Hayes on 2/14/15.
//  Copyright (c) 2015 Brewmium, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef CIErrorDomain
#define CIErrorDomain @"com.brewmium.error"
#endif
#define CIErrorMessageKey	@"error_msg"

typedef NS_ENUM(NSInteger, FFLogLevel) {
	FFLogLevel_error = 0,
	FFLogLevel_warning,
	FFLogLevel_info,
	FFLogLevel_verbose,
	
	// not level based
	FFLogLevel_bluetooth,
	FFLogLevel_api,
};

#if DEBUG
#define FFLogCompiledLevel	FFLogLevel_info
#else
#define FFLogCompiledLevel	FFLogLevel_warning
#endif

#if FFLogCompiledLevel >= FFLogLevel_verbose
#define FFLogVerbose(...)	do {[FFLog log:[NSString stringWithFormat:__VA_ARGS__] level:FFLogLevel_verbose];} while(0)
#else
#define FFLogVerbose(...)
#endif

#if FFLogCompiledLevel >= FFLogLevel_info
#define FFLogInfo(...)		do {[FFLog log:[NSString stringWithFormat:__VA_ARGS__] level:FFLogLevel_info];} while(0)
#else
#define FFLogInfo(...)
#endif

#if FFLogCompiledLevel >= FFLogLevel_warning
#define FFLogWarning(...)	do {[FFLog log:[NSString stringWithFormat:__VA_ARGS__] level:FFLogLevel_warning];} while(0)
#else
#define FFLogWarning(...)
#endif

#if FFLogCompiledLevel >= FFLogLevel_error
#define FFLogError(...)		do {[FFLog log:[NSString stringWithFormat:__VA_ARGS__] level:FFLogLevel_error];} while(0)
#else
#define FFLogError(...)
#endif

#if kShowBlueToothLogs
#define FFLogBT(...)		do {[FFLog log:[NSString stringWithFormat:__VA_ARGS__] level:FFLogLevel_bluetooth];} while(0)
#else
#define FFLogBT(...)
#endif

#if kShowAPILogs
#define FFLogAPI(...)		do {[FFLog log:[NSString stringWithFormat:__VA_ARGS__] level:FFLogLevel_api];} while(0)
#else
#define FFLogAPI(...)
#endif



@interface FFLog : NSObject

+ (void)setLogLevel:(FFLogLevel)newLevel;
+ (FFLogLevel)getLogLevel;
+ (void)log:(NSString *)str level:(FFLogLevel)level;

@end
