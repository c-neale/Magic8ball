//
//  CircleWithCutout.h
//  Magic8Ball
//
//  Created by Cory Neale on 11/05/2014.
//
//

#import <UIKit/UIKit.h>

@interface CircleWithCutout : UIView
{
    UIColor * mainColor;
}

- (id) initWithRadius:(CGFloat)radius at:(CGPoint)center mainColor:(UIColor*)main;

@end
