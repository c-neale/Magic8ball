//
//  InsetView.m
//  Magic8Ball
//
//  Created by Cory Neale on 18/05/2014.
//
//

#import "InsetView.h"

@implementation InsetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [self.layer setBorderWidth:1.0f];
        [self.layer setCornerRadius:10.0f];
        
        CGRect bounds = [self bounds];
        
        CAShapeLayer* shadowLayer = [CAShapeLayer layer];
        [shadowLayer setFrame:[self bounds]];
        
        // Standard shadow stuff
        [shadowLayer setShadowColor:[[UIColor colorWithWhite:0 alpha:1] CGColor]];
        [shadowLayer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
        [shadowLayer setShadowOpacity:1.0f];
        [shadowLayer setShadowRadius:5];
        
        // Causes the inner region in this example to NOT be filled.
        [shadowLayer setFillRule:kCAFillRuleEvenOdd];
        
        // Create the larger rectangle path.
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectInset(bounds, -42, -42));
        
        // Add the inner path so it's subtracted from the outer path.
        // someInnerPath could be a simple bounds rect, or maybe
        // a rounded one for some extra fanciness.
//        CGPathAddPath(path, NULL, someInnerPath);
        CGPathCloseSubpath(path);
        
        [shadowLayer setPath:path];
        CGPathRelease(path);
        
        [[self layer] addSublayer:shadowLayer];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
