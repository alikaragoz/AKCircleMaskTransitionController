//
//  AppDelegate.m
//  CircleMaskDemo
//
//  Created by Ali Karagoz on 19/12/14.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = firstViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
