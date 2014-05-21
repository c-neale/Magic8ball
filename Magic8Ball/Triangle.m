//
//  Triangle.m
//  Magic8Ball
//
//  Created by Cory Neale on 5/05/2014.
//
//

#import "Triangle.h"

#import <math.h>

#define DISABLE_FLOAT

@implementation Triangle

@synthesize messageLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor * backColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.33f];
        [self setBackgroundColor:backColor];
        
        // add the message to the view.
        
        messageLabel = [[UILabel alloc] initWithFrame:self.frame];
        [messageLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:messageLabel];
        
        // store the original position of this element. the triangle is going to sway.
        // we want to contrain it around the original point so that it doesn't wander off...
        origin = frame.origin;
        
        reverse = YES;
        
#ifndef DISABLE_FLOAT
        float angle = [self randomFloatInRange:5.0f toMax:10.0f] * (M_PI / 180.0f);
        CGPoint pt = [self randomPoint];
        [self floatWithAngle:angle ToPosition:pt];
#endif
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 0.941f, 1.0f);

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
    [UIView animateWithDuration:[self randomFloatInRange:4.0f toMax:8.0f]
                          delay:[self randomFloatInRange:0.0f toMax:0.5f]
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         // add the translation for the new point.
                         CGAffineTransform trans = CGAffineTransformMakeTranslation(point.x, point.y);
                         
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
                         
                         CGPoint pt = [self randomPoint];
                         
                         [self floatWithAngle:angle ToPosition: pt];
                     }];
}

- (CGPoint) randomPoint
{
    float xPos = [self randomFloatInRange:-10.0f toMax:10.0f];
    float yPos = [self randomFloatInRange:-10.0f toMax:10.0f];
    
    return CGPointMake(xPos, yPos);
}

- (float) randomFloatInRange:(float)minDegrees toMax:(float)maxDegrees
{
    return minDegrees + rand() / ((float)RAND_MAX/(maxDegrees - minDegrees));
}

@end
