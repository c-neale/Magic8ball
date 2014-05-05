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
        
        float halfWidth = frame.size.width * 0.5f;
        float halfHeight = frame.size.height * 0.5f;
        float triWidth = frame.size.width * 0.7f;
        float triHeight = frame.size.height * 0.7f;
        
        CGRect triRect = CGRectMake(halfWidth - (triWidth * 0.5f), halfHeight - (triHeight * 0.5f), triWidth, triHeight);
        Triangle * tri = [[Triangle alloc] initWithFrame:triRect];
        
        [self addSubview:tri];
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
