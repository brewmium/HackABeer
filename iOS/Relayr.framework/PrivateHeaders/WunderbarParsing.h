@class RelayrDevice;    // Relayr.framework (Public)
@protocol RLAService;   // Relayr.framework (Service)
@import Foundation;     // Apple

@interface WunderbarParsing : NSObject

/*!
 *  @abstract This method parses a blob of data coming from a specific service from a specific device and returns a dictionary with the meaning and value received.
 *  @discussion The returned dictionary keys are <code>NSString</code> with the meaning parsed. The dictionary values are <code>NSObject</code> with the format of the meaning (whether a number, array, etc).
 *
 *  @return Dictionary with <code>NSString</code> specifying the meaning as keys, and values.
 */
+ (NSDictionary*)parseData:(NSData*)data fromService:(id<RLAService>)service device:(RelayrDevice*)device atDate:(NSDate**)date;

@end
