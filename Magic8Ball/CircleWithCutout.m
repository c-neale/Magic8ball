//
//  CircleWithCutout.m
//  Magic8Ball
//
//  Created by Cory Neale on 11/05/2014.
//
//

#import "CircleWithCutout.h"

//#define DISABLE_CUTOUT

@implementation CircleWithCutout

@synthesize color;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // get the current context.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);

    // first draw a circle. we need something to cutout of
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    // set up the colors that we are using for the gradient.
    CGFloat colors [] =
    {
        1.0f, 1.0f, 1.0f, 1.0f,     // solid white
        1.0f, 1.0f, 1.0f, 0.0f,     // transparent
    };
    
    // create the gradient object using rgb color,
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGColorSpaceRelease(colorSpace);  // we need to make sure to release this even though we are using ARC...
    
    CGContextSaveGState(ctx);
    
    // create a clipping path so that our gradient only applies to our circle.
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClosePath (ctx);
    CGContextClip (ctx);
    
    CGPoint gradientOrigin = CGPointMake(rect.origin.x + rect.size.width * 0.25f,
                                         rect.origin.y + rect.size.height * 0.25f);
    
    CGContextDrawRadialGradient(ctx,
                                gradient,
                                gradientOrigin,                        // start center point
                                0,                                  // start radius
                                gradientOrigin,                        // end center point
                                self.frame.size.width * 0.5f,              // end radius
                                kCGGradientDrawsAfterEndLocation);  // to be honest, I'm not sure what this option does...
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(ctx);
    
    // now we do the cutout bit...

#ifndef DISABLE_CUTOUT
    // set the blend mode.
    CGContextSetBlendMode(ctx, kCGBlendModeDestinationOut);
    
    // now we draw another circle (this is the cutout bit.
    CGContextBeginPath(ctx);
    
    CGRect cutoutRect = CGRectMake(rect.origin.x + (rect.size.width * 0.25f),
                                   rect.origin.y + (rect.size.height * 0.25f),
                                   rect.size.width * 0.5f,
                                   rect.size.height * 0.5f);
    
    CGContextAddEllipseInRect(ctx, cutoutRect);
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
#endif
}

@end
