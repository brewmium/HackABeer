@class RelayrUser;              // Relayr.framework (Public)
@class RelayrInput;             // Relayr.framework (Public/IoT)
@import Foundation;             // Apple

/*!
 *  @abstract Specifies the basic functionality of a device.
 */
@interface RelayrDeviceModel : NSObject <NSCopying,NSMutableCopying>

/*!
 *  @abstract The User currently "using" this device.
 *  @discussion A public device can be owned by another Relayr user, but being used by your <code>RelayrUser</code> entity.
 *  All RelayrSDK objects (except when explicitly said otherwise) will return the same instance when copied (e.g.: when added to a dictionary). Thus the <code>NSCopying</code> method <code>-copyWithZone:</code> will return the same instance. Same happening with <code>NSMutableCopying</code> method <code>-mutableCopyWithZone:</code>.
 */
@property (readonly,weak,nonatomic) RelayrUser* user;

/*!
 *  @abstract The identifier of the device model within the relayr Cloud.
 *  @discussion Inmutable
 */
@property (readonly,nonatomic) NSString* modelID;

/*!
 *  @abstract Device-Model name.
 *  @discussion Inmutable
 */
@property (readonly,nonatomic) NSString* modelName;

/*!
 *  @abstract The manufacturer of the device.
 */
@property (readonly,nonatomic) NSString* manufacturer;

/*!
 *  @abstract An array containing all possible firmware models (<code>RelayrFirmwareModel</code>) for the current <code>RelayrDeviceModel</code>.
 */
@property (readonly,nonatomic) NSArray* firmwaresAvailable;

/*!
 *  @abstract Returns an array of all possible readings the device can collect.
 *  @discussion Each item in this array is an object of type <code>RelayrInput</code>. 
 *      Each input represents a different kind of reading.
 *      That is, a <code>RelayrDevice</code> can have a luminosity sensor and a gyroscope;
 *      Therefore, this array would have two different inputs.
 *
 *  @see RelayrInput
 */
@property (readonly,nonatomic) NSSet* inputs;

/*!
 *  @abstract Returns a <code>RelayrInput</code> supporting the passed meaning.
 *  @discussion If there are more than one input supporting the passed meaning, only one will be returned. It could be different on different passes of the method called (since the inputs are stored in a <code>NSSet</code>).
 *  @param meaning <code>NSString</code> specifying the desired <code>meaning</code>.
 *	@return <code>RelayrInput</code> or <code>nil</code>.
 *
 *  @see RelayrInput
 */
- (RelayrInput*)inputWithMeaning:(NSString*)meaning;

/*!
 *  @abstract Returns an array of possible Outputs a Device is capable of receiving.
 *  @discussion By 'Output' we refer to an object with commands or configuration settings sent to a Device.
 *	These are usually infrarred commands, ultrasound pulses etc.
 *	Each item in this array is an object of type <code>RelayrOutput</code>.
 *
 *  @see RelayrOutput
 */
@property (readonly,nonatomic) NSSet* outputs;

@end
