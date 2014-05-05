//
//  Triangle.h
//  Magic8Ball
//
//  Created by Cory Neale on 5/05/2014.
//
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface Triangle : UIView
{
    float rotation;
}

@property (strong, nonatomic) CMMotionManager *motionManager;

@end
