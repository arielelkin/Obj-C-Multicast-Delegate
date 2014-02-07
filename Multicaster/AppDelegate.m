//
//  AppDelegate.m
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    ViewController *viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    
    self.window.rootViewController = viewController;

    [self.window makeKeyAndVisible];

    return YES;
}
							
@end
