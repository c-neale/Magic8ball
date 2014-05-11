//
//  CircleWithCutout.m
//  Magic8Ball
//
//  Created by Cory Neale on 11/05/2014.
//
//

#import "CircleWithCutout.h"

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
    
    // now we do the cutout bit...
    
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
}

@end
