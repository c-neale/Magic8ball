//
//  GyroStabilizedView.m
//  Magic8Ball
//
//  Created by Cory Neale on 7/05/2014.
//
//

#import "GyroStabilizedView.h"

@implementation GyroStabilizedView

@synthesize motionManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor * backColor = [UIColor colorWithRed:1.0f green:0.5f blue:0.12f alpha:0.33f];
        
        [self setBackgroundColor:backColor];
        
        motionManager = [[CMMotionManager alloc] init];
        [motionManager setGyroUpdateInterval:0.2f];
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                   withHandler:^(CMGyroData *gyroData, NSError *error) {
                                       
                                       [UIView animateWithDuration:0.2f
                                                             delay:0.0f
                                                           options:UIViewAnimationOptionCurveEaseInOut
                                                        animations:^{
                                                            
                                                            // rotate around the z axis
                                                            self.transform = CGAffineTransformMakeRotation(gyroData.rotationRate.z);
                                                        }
                                                        completion:^(BOOL finished) {}];
                                   }];
        
    }
    return self;
}

@end
