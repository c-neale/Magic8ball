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

#import "CircleWithCutout.h"

@interface StartViewController ()
{
    Circle * overlay;
    Triangle * mainTriangle;
}

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
/*        Circle * c = [[Circle alloc] initWithFrame:rect];
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
        mainTriangle = [[Triangle alloc] initWithFrame:testRect];
        
        // add the triangle to the gyro view
        [gyroView addSubview:mainTriangle];
        
        // and finally add the gyro view to the circle.
        [c addSubview:gyroView];
        
        // create and add a second circle over the top.
        overlay = [[Circle alloc] initWithFrame:rect];
        [overlay setColor:[UIColor blueColor]];
        [overlay setAlpha:0.0f]; // start invisible
        [self.view addSubview:overlay];
        */
        CGRect largerRect = CGRectMake(100.0f, rect.origin.y, rect.size.width * 1.0f, rect.size.height * 1.0f);
        CircleWithCutout * ct = [[CircleWithCutout alloc] initWithFrame:largerRect];
        [ct setColor:[UIColor yellowColor]];
        [self.view addSubview:ct];
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
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.0f];
    overlay.alpha = 1.0f;
    [UIView commitAnimations];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // TODO: change the label to random message!
    [[mainTriangle messageLabel] setText:[self randomMessage]];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:3.0f];
    [UIView setAnimationDuration:2.0f];
    overlay.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // TODO: restore view to original...
}

- (NSString *)randomMessage
{
    NSArray * messages = [[NSArray alloc] initWithObjects:
                          // Positive
                          @"It is certain",
                          @"It is decidedly so",
                          @"Without a doubt",
                          @"Yes definately",
                          @"You may rely on it",
                          @"As I see it, yes",
                          @"Most likely",
                          @"Outlook good",
                          @"Yes",
                          @"Signs point to yes",
                          // indeterminate
                          @"Reply hazy try again",
                          @"Ask again later",
                          @"Better not tell you now",
                          @"Cannot predict now",
                          @"Concentrate and ask again",
                          // negative
                          @"Don't count on it",
                          @"My reply is no",
                          @"My sources say no",
                          @"Outlook not so good",
                          @"Very doubtful", nil];
    
    int randomIndex = arc4random_uniform([messages count]);
    
    return [messages objectAtIndex:randomIndex];
}

@end
