//
//  ResultViewController.h
//  Magic8Ball
//
//  Created by Cory Neale on 2/05/2014.
//
//

#import <UIKit/UIKit.h>

#import "GAITrackedViewController.h"

@interface ResultViewController : GAITrackedViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)backButtonPressed:(id)sender;

@end
