//
//  Triangle.h
//  Magic8Ball
//
//  Created by Cory Neale on 5/05/2014.
//
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface Triangle : UIView
{
    BOOL reverse;
    
    CGPoint origin;
}

@property (strong, nonatomic) UILabel * messageLabel;

@end
