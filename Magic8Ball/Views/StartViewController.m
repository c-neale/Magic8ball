//
//  StartViewController.m
//  Magic8Ball
//
//  Created by Cory Neale on 2/05/2014.
//
//

#import "StartViewController.h"
#import "AboutViewController.h"

#import "Circle.h"
#import "Triangle.h"
#import "GyroStabilizedView.h"

#import "CircleWithCutout.h"

#import "UIColor+CustomColors.h"

@interface StartViewController ()
{
    Circle * overlay;
    Triangle * mainTriangle;
}

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGPoint screenCenter = CGPointMake(screenRect.origin.x + screenRect.size.width * 0.5f, screenRect.origin.y + screenRect.size.height * 0.5f);
        
        // first, draw the backgroud circle
        CGRect circleRect = CGRectMake(screenCenter.x - 100.0f, screenCenter.y - 100.0f, 200.0f, 200.0f);
        
        Circle * baseCircle = [[Circle alloc] initWithFrame:circleRect];
        [baseCircle setColor:[UIColor centerColor]];
        [self.view addSubview:baseCircle];
        
        // calculate where the triangle will go.
        float halfWidth = baseCircle.frame.size.width * 0.5f;
        float halfHeight = baseCircle.frame.size.height * 0.5f;
        float triWidth = baseCircle.frame.size.width * 0.8f;
        float triHeight = baseCircle.frame.size.height * 0.8f;
        
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
        [baseCircle addSubview:gyroView];
        
        // create and add a second circle over the top.
        overlay = [[Circle alloc] initWithFrame:circleRect];
        [overlay setColor:[UIColor centerColor]];
        [overlay setAlpha:0.0f]; // start invisible
        [self.view addSubview:overlay];
        
        CircleWithCutout * ct = [[CircleWithCutout alloc] initWithRadius:200.0f
                                                                      at:screenCenter
                                                               mainColor:[UIColor sphereColor]];
        
        [self.view addSubview:ct];
        
        /* add info button to navigation bar */
        
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:self action:@selector(infoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        [self.navigationItem setLeftBarButtonItem:modalButton animated:YES];
        
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
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
    {
        NSLog(@"begin Shake!");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0f];
        overlay.alpha = 1.0f;
        [UIView commitAnimations];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // TODO: need tp find how to make the previous animatiom complete before starting this.
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
    {
        NSLog(@"end Shake!");

        [[mainTriangle messageLabel] setText:[self randomMessage]];
    
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:2.0f];
        [UIView setAnimationDuration:1.0f];
        overlay.alpha = 0.0f;
        [UIView commitAnimations];
    }
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"shake cancelled");
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

- (void)infoButtonAction
{
    NSLog(@"info button pressed");
}

- (IBAction)aboutButtonPressed:(id)sender
{
    AboutViewController * avc = [[AboutViewController alloc] init];

    [self.navigationController pushViewController:avc animated:YES];
}
@end
