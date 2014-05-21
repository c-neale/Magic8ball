//
//  AboutViewController.m
//  Magic8Ball
//
//  Created by Cory Neale on 18/05/2014.
//
//

#import "AboutViewController.h"

#import "InsetView.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        CGRect viewRect = CGRectMake(30.0f, 100.0f, 200.0f, 200.0f);
        InsetView * iv = [[InsetView alloc] initWithFrame:viewRect];
        
        [self.view addSubview:iv];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    [self removeFromParentViewController];
}
@end
