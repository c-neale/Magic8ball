//
//  CircleWithCutout.m
//  Magic8Ball
//
//  Created by Cory Neale on 11/05/2014.
//
//

#import "CircleWithCutout.h"

//#define DISABLE_CIRCLE
//#define DISABLE_CUTOUT
//#define DISABLE_GRADIENT
//#define DISABLE_BLACK_SHADOW


@implementation CircleWithCutout

- (id) initWithRadius:(CGFloat)radius at:(CGPoint)center mainColor:(UIColor*)main
{
    CGRect frame = CGRectMake(center.x - radius, center.y - radius, radius * 2.0f, radius * 2.0f);
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        mainColor = main;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // get the current context.
    CGContextRef ctx = UIGraphicsGetCurrentContext();

#ifndef DISABLE_CIRCLE
    CGContextSetFillColorWithColor(ctx, mainColor.CGColor);

    // first draw a circle. we need something to cutout of
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
#endif

    // create the gradient object using rgb color,
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextSaveGState(ctx);
    
    // create a clipping path so that our gradient only applies to our circle.
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClosePath (ctx);
    CGContextClip (ctx);
    
    CGGradientRef gradient;
    
#ifndef DISABLE_BLACK_SHADOW
    CGFloat colors2 [] =
    {
        0.0f, 0.0f, 0.0f, 0.5f,     // solid black
        0.0f, 0.0f, 0.0f, 0.0f,     // invisible black
    };
    
    CGFloat loc [] =
    {
        1.0f, 0.8f, 0.0f,
    };
    
    // create the gradient object using rgb color,
    
    gradient = CGGradientCreateWithColorComponents(colorSpace, colors2, loc, 3);
    
    CGContextDrawRadialGradient(ctx,
                                gradient,
                                CGPointMake(-10.0f, -10.0f),        // start center point
                                10.0f,                                      // start radius
                                CGPointMake(rect.origin.x + rect.size.width * 0.5f, rect.origin.y + rect.size.height * 0.5f),                         // end center point
                                rect.size.width * 0.6f,           // end radius
                                0);  // to be honest, I'm not sure what this option does...
    
    CGGradientRelease(gradient);
#endif
    
    
    CGPoint gradientOrigin = CGPointMake(rect.origin.x + rect.size.width * 0.25f,
                                         rect.origin.y + rect.size.height * 0.25f);
 
#ifndef DISABLE_GRADIENT
    
    // set up the colors that we are using for the gradient.
    CGFloat colors [] =
    {
        0.722f, 0.722f, 0.722f, 0.722f,     // light grey
        1.0f, 1.0f, 1.0f, 0.0f,     // invisible white
    };
    
    gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    
    CGContextDrawRadialGradient(ctx,
                                gradient,
                                gradientOrigin,                         // start center point
                                0,                                      // start radius
                                gradientOrigin,                         // end center point
                                self.frame.size.width * 0.4f,           // end radius
                                0);  // to be honest, I'm not sure what this option does...
    
    CGGradientRelease(gradient);
#endif
    

    
    CGColorSpaceRelease(colorSpace);  // we need to make sure to release this even though we are using ARC...
    
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
