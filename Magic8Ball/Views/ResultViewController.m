//
//  ResultViewController.m
//  Magic8Ball
//
//  Created by Cory Neale on 2/05/2014.
//
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize resultLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self setScreenName:@"Result"];
    
    NSArray * messages = [[NSArray alloc] initWithObjects:@"It is certain",
                                                         @"It is decidedly so",
                                                         @"Without a doubt",
                                                         @"Yes definately",
                                                         @"You may rely on it",
                                                         @"As I see it, yes",
                                                         @"Most likely",
                                                         @"Outlook good",
                                                         @"Yes",
                                                         @"Signs point to yes",
                                                         @"Reply hazy try again",
                                                         @"Ask again later",
                                                         @"Better not tell you now",
                                                         @"Cannot predict now",
                                                         @"Concentrate and ask again",
                                                         @"Don't count on it",
                                                         @"My reply is no",
                                                         @"My sources say no",
                                                         @"Outlook not so good",
                                                         @"Very doubtful", nil];
    
    int randomIndex = arc4random_uniform([messages count]);
    
    [resultLabel setText: [messages objectAtIndex:randomIndex]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender
{
    //[self removeFromParentViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
