//
//  Triangle.m
//  Magic8Ball
//
//  Created by Cory Neale on 5/05/2014.
//
//

#import "Triangle.h"

#import <math.h>

@implementation Triangle

//@synthesize motionManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        /*
         motionManager = [[CMMotionManager alloc] init];
         motionManager.gyroUpdateInterval = 0.2f;
         
         [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
         withHandler:^(CMGyroData *gyroData, NSError *error)
         {
         [self rotateToAngle:gyroData.rotationRate.z];
         }];
         */
        
        reverse = YES;
        
        float angle = [self randomFloatInRange:5.0f toMax:10.0f] * (M_PI / 180.0f);
        [self rotateToAngle:angle];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
    
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

- (void)rotateToAngle:(float)radians
{
    NSLog(@"angle: %0.4fr (%0.2fd) reverse: %@", radians, radians * (180.0f/M_PI), reverse == YES ? @"YES" : @"NO");
    
    [UIView animateWithDuration:[self randomFloatInRange:4.0f toMax:8.0f]
                          delay:[self randomFloatInRange:0.0f toMax:0.5f]
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeRotation(radians);
                     }
                     completion:^(BOOL finished) {
                         // get the angle and convert to radians.
                         float angle = [self randomFloatInRange:5.0f toMax:10.0f] * (M_PI / 180.0f);
                         angle *= reverse ? -1.0f : 1.0f;
                         reverse = !reverse;
                         
                         [self rotateToAngle:angle];
                     }];
}

- (float) randomFloatInRange:(float)minDegrees toMax:(float)maxDegrees
{
    return minDegrees + rand() / ((float)RAND_MAX/(maxDegrees - minDegrees));
}

@end
