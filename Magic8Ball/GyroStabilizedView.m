//
//  GyroStabilizedView.m
//  Magic8Ball
//
//  Created by Cory Neale on 7/05/2014.
//
//

#import "GyroStabilizedView.h"

#define DISABLE_GYRO

@implementation GyroStabilizedView

@synthesize motionManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor * backColor = [UIColor colorWithRed:1.0f green:0.5f blue:0.12f alpha:0.33f];
        
        [self setBackgroundColor:backColor];
        
        // initialise the angle to zero.
        currentAngle = 0.0f;
        
        motionManager = [[CMMotionManager alloc] init];
        
        const float gyroUpdateInterval = 0.2f;
        const float accelUpdateInterval = 0.2f;
        
        [motionManager setGyroUpdateInterval:gyroUpdateInterval];
        [motionManager setAccelerometerUpdateInterval:accelUpdateInterval];
 
#ifndef DISABLE_GYRO
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                   withHandler:^(CMGyroData *gyroData, NSError *error) {
                                       
                                       // filter out any small residual values. the gyroscope
                                       // seems to return small values when sitting stationary on
                                       // a table.
                                       if(fabs(gyroData.rotationRate.z) <= 0.01 )
                                            return;

                                       // the data returned from the gyroscope is returned in units
                                       // of radians per second. we know the update interval, so if we
                                       // multiply the value by the update interval, we should get the
                                       // angle in radians since the last update.
                                       float angleRadians = gyroData.rotationRate.z * gyroUpdateInterval;
                                       
                                       currentAngle += angleRadians;
                                       
                                       [UIView animateWithDuration:0.2f
                                                             delay:0.0f
                                                           options:UIViewAnimationOptionCurveEaseInOut
                                                        animations:^{
                                                            
                                                            // rotate around the z axis
                                                            self.transform = CGAffineTransformMakeRotation(currentAngle);
                                                        }
                                                        completion:nil];
                                   }];
#endif
        
        // using the accelerometer method is more reliable.  the gyro sensor will only return rates of rotation, so it impossible to
        // detect the initial orientation.  This means that if the app is started in landscape orientation, the rotation info that
        // the app has access to will always be 90 degrees out.
        
        // we could probably use some sort of hybrid approach - use the accelerometer to get the initial orientation and then use the
        // gyro data to maintain, perhaps with periodic calls to the accelerometer to check and correct any inaccuracies.
        
        // for whats its worth, i don't think its worth following this approach at the moment.  Although the accelerometer method uses
        // some more advanced math functions which are most likely slower (I have no idea of the performance hit of using acosf() function),
        // the app is small enough that we have the capacity to take this hit. changing to the hybrid approach will just be making thing more
        // complicated for no noticeable gains.
        
        // I may however change it over to a hybrid method at a later stage - just for the fun of the challenge.
        
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler:^(CMAccelerometerData *accelData, NSError *error) {
                                               
                                               // NSLog(@"x: %0.3f y: %0.3f z: %0.3f", accelData.acceleration.x, accelData.acceleration.y, accelData.acceleration.z);
                                                
                                                // TODO: need to work out the maths to do this.
                                                
                                                // sample rotation data:
                                                //                        x     y    z
                                                // upright:              0.0, -1.0, 0.0
                                                // upside down:          0.0,  1.0, 0.0
                                                // rotate left:         -1.0,  0.0, 0.0
                                                // rotate right:         1.0,  0.0, 0.0
                                                // 45 deg left:         -0.5, -0.5, 0.0
                                                
                                                /*
                                                int vector_dotprod(Vector a, Vector b) {
                                                    return (a.x * b.x + a.y * b.y + a.z * b.z);
                                                }
                                                 */
                                                
                                                // so lets make a our resting baseline upright (0.0, -1.0, 0.0)
                                                // and b will be our accelerometer data.
                                                
                                                // we are basically doing a dot product on 2 vectors here to work out the angle between the
                                                // data from the accelerometer and its normal resting orientation.
                                                float cosine = (0.0f * accelData.acceleration.x) + (-1.0f * accelData.acceleration.y);
                                                
                                                // for acosf to work, the number needs to be in the rangs -1 <= x <= 1
                                                // if its outside this range it will return NaN
                                                cosine = [self number:cosine inMinRange:-1.0f toMaxRange:1.0f];
                                                
                                                float angle = acosf(cosine);
                                                angle *= accelData.acceleration.x < 0 ? 1.0f : -1.0f;
                                                // TODO: need to work out the direction.
                                                
                                                NSLog(@"current angle from upright: %0.2f (x: %0.2f y: %0.2f)", angle, accelData.acceleration.x, accelData.acceleration.y);
                                                
                                                [UIView animateWithDuration:0.2f
                                                                      delay:0.0f
                                                                    options:UIViewAnimationOptionCurveEaseInOut
                                                                 animations:^{
                                                                     
                                                                     // rotate around the z axis
                                                                     self.transform = CGAffineTransformMakeRotation(angle);
                                                                 }
                                                                 completion:nil];
                                            }];
        
    }
    return self;
}

- (float)number:(float)num inMinRange:(float)minRange toMaxRange:(float)maxRange
{
    num = MAX(num, minRange);
    return MIN(num, maxRange);
}

@end
