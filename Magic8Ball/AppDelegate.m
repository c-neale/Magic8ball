//
//  AppDelegate.m
//  Magic8Ball
//
//  Created by Cory Neale on 2/05/2014.
//
//

#import "AppDelegate.h"

#import "StartViewController.h"

#import "GAI.h"

#define DISABLE_ANALYTICS

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Set a root view controller so the app knows where to start...
    StartViewController * svc = [[StartViewController alloc] init];

    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:svc];
    
    [[self window] setRootViewController:navController];
        
    // Google Analytics initilisation code:
#ifndef DISABLE_ANALYTICS
    // send uncaught exceptions to google...
    [[GAI sharedInstance] setTrackUncaughtExceptions:YES];
    
    // set the dispatch interval to 20s
    [[GAI sharedInstance] setDispatchInterval:20];
    
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-50634961-1"];
#endif
    
    [self checkAndSetDefaults];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)checkAndSetDefaults
{
    // get the location of the pList file from the settings.bundle
    NSString * settingsPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Settings.bundle"];
    NSString * pListFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];
    
    // get the preference specifiers array. this contains the settings
    NSDictionary * settingDict = [NSDictionary dictionaryWithContentsOfFile:pListFile];
    NSArray * prefsArray = [settingDict objectForKey:@"PreferenceSpecifiers"];
    
    // get the shared defaults object
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    // loop through the preference items and set the default value if no value is set.
    for(NSDictionary * item in prefsArray)
    {
        // get the item key
        NSString * key = [item objectForKey:@"Key"];
        if (key)
        {
            // get the current value and the default value. if either of these is not
            // set then they will return nil
            id value = [defaults objectForKey:key];
            id defaultValue = [item objectForKey:@"DefaultValue"];
            
            if (!value && defaultValue)
            {
                [defaults setObject:defaultValue forKey:key];
            }
        }
    }
    
    // write the changes back to disk for next time.
    [defaults synchronize];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
