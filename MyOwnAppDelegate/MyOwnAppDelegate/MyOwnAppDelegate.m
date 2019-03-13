//
//  MyOwnAppDelegate.m
//  MyOwnAppDelegate
//
//  Created by Dmitry Shapkin on 13/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "MyOwnAppDelegate.h"
#import "MyOwnViewController.h"
#import "MySecondViewController.h"
#import "MyThirdViewController.h"

@implementation MyOwnAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"didFinishLaunchingWithOptions");
    
    //NSLog(@"%@", [self.window gestureRecognizers]);
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.redColor;
    
    UIViewController* vc = [[MySecondViewController alloc] init];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
