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
        [self setBackgroundColor:[UIColor greenColor]];
        
        // store the original position of this element. the triangle is going to sway.
        // we want to contrain it around the original point so that it doesn't wander off...
        origin = frame.origin;
        
        reverse = YES;
        
        float angle = [self randomFloatInRange:5.0f toMax:10.0f] * (M_PI / 180.0f);
        CGPoint pt = [self randomPointAroundPoint:origin];
        [self floatWithAngle:angle ToPosition:pt];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
    
    CGContextBeginPath(ctx);
    
    // Add a triangle to the current path
    CGPoint center = CGPointMake(rect.origin.x + (rect.size.width * 0.5f), rect.origin.y + (rect.size.height * 0.5f));
    CGFloat halfWidth = rect.size.width * 0.5f;
    
    CGContextMoveToPoint(ctx, center.x, center.y + halfWidth);
    for(int i = 1; i < 3; ++i)
    {
        CGFloat x = halfWidth * sinf(i * 4.0f * M_PI / 3.0f);
        CGFloat y = halfWidth * cosf(i * 4.0f * M_PI / 3.0f);
        CGContextAddLineToPoint(ctx, center.x + x, center.y + y);
    }
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

- (void)floatWithAngle:(float)radians ToPosition:(CGPoint)point
{
//    NSLog(@"width: %0.2f height: %0.2f", self.frame.size.width, self.frame.size.height);
    
    [UIView animateWithDuration:[self randomFloatInRange:4.0f toMax:8.0f]
                          delay:[self randomFloatInRange:0.0f toMax:0.5f]
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         //CGAffineTransformMakeTranslation(self.frame.origin.x - origin.x, self.frame.origin.y - origin.y);
                         
                         //NSLog(@"origin: %0.2f,%0.2f", origin.x, origin.y);
                         //NSLog(@"curren: %0.2f,%0.2f", self.frame.origin.x, self.frame.origin.y);
                         //NSLog(@"revers: %0.2f,%0.2f", self.frame.origin.x - origin.x, self.frame.origin.y - origin.y);
                         
                         // translate back towards the origin.  this will contrain it to float around a point.
                         CGAffineTransform trans = CGAffineTransformMakeTranslation(self.frame.origin.x - origin.x, self.frame.origin.y - origin.y);
                         
                         // add the translation for the new point.
                         trans = CGAffineTransformTranslate(trans, point.x, point.y);
                         
                         // and finally add the rotation.
                         trans = CGAffineTransformRotate(trans, radians);

                         // and assign it back to the view.
                         self.transform = trans;
                     }
                     completion:^(BOOL finished) {
                         // get the angle and convert to radians.
                         float angle = [self randomFloatInRange:5.0f toMax:10.0f] * (M_PI / 180.0f);
                         angle *= reverse ? -1.0f : 1.0f;
                         reverse = !reverse;
                         
                         CGPoint pt = [self randomPointAroundPoint:origin];
                         
                         [self floatWithAngle:angle ToPosition:pt];
                     }];
}

- (CGPoint) randomPointAroundPoint:(CGPoint)pt
{
    float xPos = /*pt.x +*/ [self randomFloatInRange:-30.0f toMax:30.0f];
    float yPos = /*pt.y +*/ [self randomFloatInRange:-30.0f toMax:30.0f];
    
//    NSLog(@"xPos: %0.2f yPos: %0.2f", xPos, yPos);
    
    return CGPointMake(xPos, yPos);
}

- (float) randomFloatInRange:(float)minDegrees toMax:(float)maxDegrees
{
    return minDegrees + rand() / ((float)RAND_MAX/(maxDegrees - minDegrees));
}

@end
