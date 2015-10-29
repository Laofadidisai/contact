//
//  LHAppDelegate.m
//  Contact
//
//  Created by 老李 on 15-10-28.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "LHAppDelegate.h"
#import "ViewController.h"
@implementation LHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController * viewVC = [[ViewController alloc]init];
    self.window.rootViewController = viewVC;
    
    
    
    
    return YES;
}

@end
