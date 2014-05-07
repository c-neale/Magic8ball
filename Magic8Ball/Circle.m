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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        
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
