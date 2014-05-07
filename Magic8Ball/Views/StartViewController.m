//
//  StartViewController.m
//  Magic8Ball
//
//  Created by Cory Neale on 2/05/2014.
//
//

#import "StartViewController.h"
#import "ResultViewController.h"

#import "Circle.h"
#import "Triangle.h"
#import "GyroStabilizedView.h"

@interface StartViewController ()

@end

@implementation StartViewController

@synthesize messageLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // first, draw the backgroud circle
        CGRect rect = CGRectMake(50.0f, 100.0f, 200.0f, 200.0f);
        Circle * c = [[Circle alloc] initWithFrame:rect];
        [self.view addSubview:c];
        
        // calculate where the triangle will go.
        float halfWidth = c.frame.size.width * 0.5f;
        float halfHeight = c.frame.size.height * 0.5f;
        float triWidth = c.frame.size.width * 0.8f;
        float triHeight = c.frame.size.height * 0.8f;
        
        CGRect triRect = CGRectMake(halfWidth - (triWidth * 0.5f), halfHeight - (triHeight * 0.5f), triWidth, triHeight);
        
        // create a GyroStabilizedView.  this will hold the triangle and allow us to animate
        // and align the triangle independant of the floating motion of the triangle.
        GyroStabilizedView * gyroView = [[GyroStabilizedView alloc] initWithFrame:triRect];
        
        // create the triangle.
        CGRect testRect = CGRectMake(0.0f, 0.0f, triWidth, triHeight);
        Triangle * tri = [[Triangle alloc] initWithFrame:testRect];
        
        // add the triangle to the gyro view
        [gyroView addSubview:tri];
        
        // and finally add the gyro view to the circle.
        [c addSubview:gyroView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setScreenName:@"Start"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // TODO: change the view when shake begins
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // TODO: restore view to original...
}

@end
