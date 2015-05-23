@class RelayrDeviceModel;   // Relayr.framework (Public/IoTs)
@import Foundation;         // Apple

/*!
 *  @abstract Represents a type of writing/output (command or configuration) a relayr device (for example, a sensor) can receive.
 *  @discussion All RelayrSDK objects (except when explicitly said otherwise) will return the same instance when copied (e.g.: when added to a dictionary). Thus the <code>NSCopying</code> method <code>-copyWithZone:</code> will return the same instance. Same happening with <code>NSMutableCopying</code> method <code>-mutableCopyWithZone:</code>.
 */
@interface RelayrOutput : NSObject <NSCopying,NSMutableCopying>

/*!
 *  @abstract The source of the output/writing. 
 *  @discussion This property will never be <code>nil</code>.
 */
@property (readonly,weak,nonatomic) RelayrDeviceModel* deviceModel;

/*!
 *  @abstract The name of the type of writing/output the <code>RelayrDevice</code> can receive.
 *  @discussion Currently only two types of meanings are accepted: "led" and <code>nil</code>.
 */
@property (readonly,nonatomic) NSString* meaning;

/*!
 *  @abstract Sends the value to the device containing this <code>RelayrOutput</code>.
 *  @discussion Currently only <code>NSString</code> values are accepted. This will change in future releases.
 *
 *  @param value NSString in UTF8 format to send to the <code>RelayrDevice</code>
 *  @param completion A Block indicating whether the value was received by the server (<code>error</code> is <code>nil</code>) or not.
 */
- (void)sendValue:(NSString*)value
   withCompletion:(void (^)(NSError* error))completion;

@end
