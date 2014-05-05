//
//  Triangle.m
//  Magic8Ball
//
//  Created by Cory Neale on 5/05/2014.
//
//

#import "Triangle.h"

@implementation Triangle

@synthesize motionManager;

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
        
        [self rotateToAngle:M_PI];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
    
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // mid right
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom left
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

- (void)rotateToAngle:(float)radians
{
    [UIView animateWithDuration:3.0f
                          delay:0.0f
                        options:0
                     animations:^{
                         self.transform = CGAffineTransformMakeRotation(radians);
                     }
                     completion:nil];
}

@end
