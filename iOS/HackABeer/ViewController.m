//
//  ViewController.m
//  HackABeer
//
//  Created by Eric Hayes on 5/23/15.
//  Copyright (c) 2015 Eric Hayes. All rights reserved.
//

#import "ViewController.h"
#import <Relayr/Relayr.h>           // Relayr.framework

#define kRelayerOn	(0)

typedef NS_ENUM(NSInteger, DisplayRole) {
	DisplayRoleTap = 0,
	DisplayRoleBartender,
	DisplayRoleOverhead,
};


@interface ViewController () {
	BOOL once;
	BOOL flipped;
	UIView *currentContainer;
//	RelayrApp* storedApp;
//	RelayrUser *relayerUser;
	NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#define RelayrAppID @"a0eb4abd-6eb8-444c-ae23-d497bfd10025"
#define RelayrClientId @"7vQVOyIE-wp6QhnC.TsU18f-F33BsB3t"
#define RelayrAppSecret @"VirEROjdpvqh9.ebYnAYC4Ax.rspkAOB"
#define RelayrAppRedirectURI    @"http://localhost"

- (void)viewDidLayoutSubviews;
{
	if ( !once ) {
		flipped = YES;
		currentContainer = self.tapContainer;
		
//		self.configContainer.frame = self.flipContainer.bounds;
		self.tapContainer.frame = self.flipContainer.bounds;
		self.aboutContainer.frame = self.flipContainer.bounds;
		[self.aboutContainer removeFromSuperview];
		
#if kRelayerOn
		[RelayrApp appWithID:RelayrAppID OAuthClientSecret:RelayrAppSecret redirectURI:RelayrAppRedirectURI completion:^(NSError* errorApp, RelayrApp* app) {
			
			if (errorApp == nil) {
				storedApp = app;
			
				[storedApp signInUser:^(NSError* errorUser, RelayrUser* user) {
					if (errorUser == nil) {
						relayerUser = user;
					}
				}];
			}
		}];
#endif
		
		timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
	}
}

#define kImpEndpoint @"https://agent.electricimp.com/lf97mOuH0DNl/data"

#define kEndpoint @"http://54.237.120.219"

- (NSURLRequest *)makePostRequest:(NSString *)endpoint
{
	// package up the full url
	NSURL *url = [NSURL URLWithString:endpoint];
	
//	// package up the param content
//	NSError *err;
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:url];
	[request setHTTPMethod:@"GET"];
//	[request setValue:[NSNumber numberWithInteger:1] forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:@"x"];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setHTTPShouldHandleCookies:NO];
	[request setTimeoutInterval:10];
	
	return request;
}


- (void)tick:(NSTimer *)timer;
{
#if kRelayerOn
	// Retrieve the transmitters and devices owned by the user.
	[relayerUser queryCloudForIoTs:^(NSError* error) {
		if (error) { return NSLog(@"There was an error retrieving the users IoT."); }
		
		// To simplify, we suppose that the user has only one transmitter (wunderbar)
		RelayrTransmitter* transmitter = relayerUser.transmitters.anyObject;
		if (!transmitter) { return NSLog(@"The user has no wunderbars."); }
		
		// The Relayr cloud mantains a specific list of "meanings" specifying the capabilities of devices. In this case we are interested in "temperature"
		RelayrDevice* device = [transmitter devicesWithInputMeaning:@"angularSpeed"].anyObject;
		if (!device) { return NSLog(@"The user hasn't onboard the angularSpeed sensor."); }
		
		[device subscribeToAllInputsWithBlock:^(RelayrDevice* device, RelayrInput* input, BOOL* unsubscribe) {
			if ([input.meaning isEqualToString:@"temperature"])
			{
				self.paleTemp.text = [NSString stringWithFormat:@"%@ ºC", input.value];
			}
//			else if ([input.meaning isEqualToString:@"humidity"])
//			{
//				_currentHumidLabel.text = [NSString stringWithFormat:@"%@ %%", input.value];
//			}
			NSLog(@"%@ = %@", input.meaning, input.value);
			
		} error:^(NSError* error) {
			NSLog(@"%@", error.localizedDescription);
		}];
	}];
#endif
	
	
//	NSURLRequest *request = [self makePostRequest:kImpEndpoint];
//	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
//		   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//			   NSError *jsonError = nil;
//			   NSDictionary * payload = nil;
//			   
//			   if ( data ) {
//				   payload = [NSJSONSerialization JSONObjectWithData:data
//															 options:NSJSONReadingMutableContainers
//															   error:&jsonError];
//				   
//				   if ( payload == nil ) {
//					   NSString *str = [[NSString alloc] initWithData:data encoding:[NSString defaultCStringEncoding]];
//					   FFLogAPI(@"[ERROR, STRING] network call: %@", str);
//					   
//				   } else {
//					   CGFloat f = [[payload objectForKey:@"temperature"] floatValue];
//					   f = f * (9.0/5.0) + 32;
//
//					   self.paleTemp.text = [NSString stringWithFormat:@"%.1f°", f];
////					   FFLogAPI(@"network call: %@", payload);
//				   }
//			   }
//			   
//		   }
//	 ];
//	
	
	
	NSURLRequest *request = [self makePostRequest:kEndpoint];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
		   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
			   NSError *jsonError = nil;
			   NSDictionary * payload = nil;
			   
			   if ( data ) {
				   payload = [NSJSONSerialization JSONObjectWithData:data
															 options:NSJSONReadingMutableContainers
															   error:&jsonError];
				   
				   if ( payload == nil ) {
//					   NSString *str = [[NSString alloc] initWithData:data encoding:[NSString defaultCStringEncoding]];
//					   FFLogAPI(@"[ERROR, STRING] network call: %@", str);
				 
				   } else {
					   [self processPayload:payload];
//					   FFLogAPI(@"network call: %@", payload);
				   }
			   }
			   
		   }
	 ];

}

- (CGFloat)c2f:(CGFloat)cel
{
	return (cel * (9.0/5.0)) + 32;
}

- (void)processPayload:(NSDictionary *)payload;
{
	self.ipaPulling.hidden = ![[payload objectForKey:@"pullIPA"] boolValue];
	self.palePulling.hidden = ![[payload objectForKey:@"pullPale"] boolValue];
	
	self.palePulls.text = [NSString stringWithFormat:@"%@", [payload objectForKey:@"countPale"]];
	self.ipaPulls.text = [NSString stringWithFormat:@"%@", [payload objectForKey:@"countIPA"]];
	
	CGFloat f = [[payload objectForKey:@"tempIPA"] floatValue];
	self.ipaTemp.text = [NSString stringWithFormat:@"%.1f°", [self c2f:f]];
	
	f = [[payload objectForKey:@"tempPale"] floatValue];
	self.paleTemp.text = [NSString stringWithFormat:@"%.1f°", [self c2f:f]];

	NSInteger i = [[payload objectForKey:@"sinceIPA"] integerValue];
	self.ipaIdle.text = [self formatTime:i];

	i = [[payload objectForKey:@"sincePale"] integerValue];
	self.paleIdle.text = [self formatTime:i];
}

- (NSString *)formatTime:(NSInteger)seconds;
{
	NSString *result = @"";
	if ( seconds > kSecondsInADay ) {
		NSInteger days = seconds / kSecondsInADay;
		result = [NSString stringWithFormat:@"%zd", days];
		seconds -= (days * kSecondsInADay);
	}
	
	if ( seconds > kSecondsInAnHour ) {
		NSInteger hours = seconds / kSecondsInAnHour;
		result = [NSString stringWithFormat:@"%@%@%@%zd", result.length > 0 ? result : @"", result.length > 0 ? @":" : @"", hours < 10 ? @"0" : @"", hours];
		seconds -= (hours * kSecondsInAnHour);
	}
	
	if ( seconds > kSecondsInAMinute ) {
		NSInteger minutes = seconds / kSecondsInAMinute;
		result = [NSString stringWithFormat:@"%@%@%@%zd", result.length > 0 ? result : @"", result.length > 0 ? @":" : @"", minutes < 10 ? @"0" : @"", minutes];
		seconds -= (minutes * kSecondsInAMinute);
	}
	
	if ( seconds == 0 ) {
		result = [NSString stringWithFormat:@"%@:00", result];
	} else {
		result = [NSString stringWithFormat:@"%@%@%@%zd", result.length > 0 ? result : @"", result.length > 0 ? @":" : @"", seconds < 10 ? @"0" : @"", seconds];
	}
	
	return result;
}

- (IBAction)showTapAction:(id)sender;
{
	if ( currentContainer == self.tapContainer) return;
	
	[self.flipContainer flipWithDirection:UIViewAnimationTransitionFlipFromLeft
								 fromView:self.aboutContainer
								   toView:self.tapContainer];
	currentContainer = self.tapContainer;
}

//- (IBAction)showConfig:(id)sender;
//{
//	if ( currentContainer == self.configContainer) return;
//	
//	UIView *from = currentContainer;
//	[self.flipContainer flipWithDirection:UIViewAnimationTransitionFlipFromLeft
//								 fromView:from
//								   toView:self.configContainer];
//	currentContainer = self.configContainer;
//}

- (IBAction)showAbout:(id)sender;
{
	if ( currentContainer == self.aboutContainer) return;
	
	[self.flipContainer flipWithDirection:UIViewAnimationTransitionFlipFromLeft
								 fromView:self.tapContainer
								   toView:self.aboutContainer];
	currentContainer = self.aboutContainer;
}

//- (IBAction)showFront:(id)sender
//{
//	switch ( role ) {
//		case DisplayRoleTap:		[self showTapAction:nil];		break;
//		case DisplayRoleBartender:	[self showBartenderAction:nil];	break;
//		case DisplayRoleOverhead:	[self showOverheadAction:nil];	break;
//	}
//}
//
@end
