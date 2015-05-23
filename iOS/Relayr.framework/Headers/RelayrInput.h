@class RelayrDevice;        // Relayr.framework (Public)
@class RelayrDeviceModel;   // Relayr.framework (Public)
@class RelayrInput;         // Relayr.framework (Public)
@import Foundation;         // Apple

/*!
 *  @abstract A Block executed when the input (the reading) receives data.
 *  @discussion All RelayrSDK objects (except when explicitly said otherwise) will return the same instance when copied (e.g.: when added to a dictionary). Thus the <code>NSCopying</code> method <code>-copyWithZone:</code> will return the same instance. Same happening with <code>NSMutableCopying</code> method <code>-mutableCopyWithZone:</code>.
 *
 *  @param device The <code>RelayrDevice</code> sending the data.
 *  @param input <code>RelayrInput</code> specifying the meaning and value of the data received.
 *  @param unsubscribe A boolean pointer that can be set to <code>YES</code> if you wish to stop the block from being further executed.
 */
typedef void (^RelayrInputDataReceivedBlock)(RelayrDevice* device, RelayrInput* input, BOOL* unsubscribe);

/*!
 *  @abstract A Block executed when the input receives an error.
 *
 *  @param error <code>NSError</code> describing the specific error.
 */
typedef void (^RelayrInputErrorReceivedBlock)(NSError* error);

/*!
 *  @abstract References the type of input (reading) a relayr Device (sensor) can collect.
 *  @discussion This object has a single 'meaning', however, This meaning could consist of one or more values. 
 *	For example: The Luminosity meaning is represented by a single value  
 *	however, the Color meaning consists of three or four values (red, green, blue, and white).
 */
@interface RelayrInput : NSObject <NSCopying,NSMutableCopying>

/*!
 *  @abstract The source of the input (reading).
 *  @discussion This property will never be <code>nil</code>.
 *      Although it is described as <code>RelayrDeviceModel</code>, 
 *		this object might be a full <code>RelayrDevice</code> if the input is associated with a <code>RelayrDevice</code>.
 */
@property (readonly,weak,nonatomic) RelayrDeviceModel* deviceModel;

/*!
 *  @abstract The name of the input (reading) as it is defined on the relayr platform.
 */
@property (readonly,nonatomic) NSString* meaning;

/*!
 *  @abstract The unit in which the input (reading) is measured.
 */
@property (readonly,nonatomic) NSString* unit;

/*!
 *  @abstract The last value received from the sensor. Either queried for or pushed.
 *  @discussion This object can be a single object entity (such as an <code>NSNumber</code> or an <code>NSString</code>) 
 *	or a collection: either a <code>NSArray</code> or an <code>NSDictionary</code>.
 */
@property (readonly,nonatomic) id value;

/*!
 *  @abstract The timestamp of the last value received.
 *  @discussion Can be seen as the 'last update' timestamp. 
 *	When <code>nil</code>, it means that a value has not yet been received or queried for.
 */
@property (readonly,nonatomic) NSDate* date;

/*!
 *  @abstract Returns an array with the last 20 or less measurements (including the one in <code>value</code>).
 *  @discussion The array will contain 20  values or less. 
 *	The object type will be the same as the <code>value</code> property. 
 *	If an object could not be measured, but a timestamp was taken, the singleton [NSNull null] is stored in the array.
 */
@property (readonly,nonatomic) NSArray* historicValues;

/*!
 *  @abstract Returns an array with the last 20 measurement times or less (including the current one in <code>date</code>).
 *  @discussion The array will contain 20 or less <code>NSDate</code> objects.
 */
@property (readonly,nonatomic) NSArray* historicDates;

/*!
 *  @abstract Subscribes a block to the data sent from the <code>RelayrDevice</code>.
 *  @discussion Regardless of how the device is connected (Cloud, Direct connection, etc.), the block is called as soon as the data is available.
 *
 *  @param block This block will be executed everytime data is available. The block contains three parameters:
 *      - <code>device</code>. The device producing the reading.
 *      - <code>input</code>. The reading value received.
 *      - <code>unsubscribe</code>. A Boolean variable, that when set to <code>NO</code>, will stop the subscription.
 *  @param errorBlock A Block executed every time an error occurs. The error could be received because the subscription could not be completed, or because the subscription is stopped by an external factor.
 */
- (void)subscribeWithBlock:(RelayrInputDataReceivedBlock)block
                     error:(RelayrInputErrorReceivedBlock)errorBlock;

/*!
 *  @abstract Subscribes the target object to a specific input of a <code>RelayrDevice</code> instance.
 *  @discussion Regardless of how the device is connected (Web/Cloud, Bluetooth, etc.), the action is called as soon as the data is available.
 *
 *  @param target The object where the <code>action</code> is called onto.
 *  @param action The method to be called. It can have two modes:
 *      - No parameters.
 *      - One parameter. The parameter must be a <code>RelayrInput</code> object, or the program will crash.
 *      - Two parameters. The first one is a <code>RelayrDevice</code> object, and the second is a <code>RelayrInput</code> object.
 *  @param errorBlock A Block executed every time an error occurs. The error could be received because the subscription could not be completed, 
 *	or because the subscription is stopped by an external factor.
 *  @warning The action selector should not return anything. If the method does return something, this will cause memory leaks.
 */
- (void)subscribeWithTarget:(id)target
                     action:(SEL)action
                      error:(RelayrInputErrorReceivedBlock)errorBlock;

/*!
 *  @abstract Unsubscribes the specific action from the target object.
 *  @discussion If a target object has more than one subscription with different actions, 
 *	this unsubscribe method only affects the actions being passed.
 *
 *  @param target The object where the subscription is being sent to.
 *  @param action The action being executed on the target each time readings arrives.
 */
- (void)unsubscribeTarget:(id)target
                   action:(SEL)action;

/*!
 *  @abstract Removes all subscriptions for the device.
 *  @discussion All subscriptions, whether blocks or target objects are unsubscribed.
 */
- (void)removeAllSubscriptions;

@end
