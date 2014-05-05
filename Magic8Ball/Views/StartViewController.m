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

@interface StartViewController ()

@end

@implementation StartViewController

@synthesize messageLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        CGRect triRect = CGRectMake(20.0f, 20.0f, 100.0f, 100.0f);
        Circle * c = [[Circle alloc] initWithFrame:triRect];
     
        [self.view addSubview:c];
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
    // TODO: push the new view controller to show the result
    ResultViewController * rvc = [[ResultViewController alloc] init];
    //[[self navigationController] pushViewController:rvc animated:YES];
    [self presentViewController:rvc animated:YES completion:nil];
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // TODO: restore view to original...
}

@end
