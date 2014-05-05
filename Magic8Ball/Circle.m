//
//  Circle.m
//  Magic8Ball
//
//  Created by Cory Neale on 5/05/2014.
//
//

#import "Circle.h"

#import "Triangle.h"

@implementation Circle

@synthesize motionManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGRect triRect = CGRectMake(40.0f, 40.0f, 40.0f, 40.0f);
        Triangle * tri = [[Triangle alloc] initWithFrame:triRect];
        
        [self addSubview:tri];
        
        motionManager = [[CMMotionManager alloc] init];
        motionManager.gyroUpdateInterval = .2;
        
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMGyroData *gyroData, NSError *error)
         {
             rotation = gyroData.rotationRate.z;
         }];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0.0f, 0.0f, 1.0f, 1.0f);
    
    CGContextBeginPath(ctx);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

@end
