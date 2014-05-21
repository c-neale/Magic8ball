//
//  GyroStabilizedView.h
//  Magic8Ball
//
//  Created by Cory Neale on 7/05/2014.
//
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GyroStabilizedView : UIView
{
    float currentAngle;
}

@property (strong, nonatomic) CMMotionManager *motionManager;

- (float)number:(float)number inMinRange:(float)minRange toMaxRange:(float)maxRange;

@end
