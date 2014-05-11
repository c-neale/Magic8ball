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

@synthesize color;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        color = [UIColor blueColor];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}


@end
