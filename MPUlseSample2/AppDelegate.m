//
//  AppDelegate.m
//  MPUlseSample2
//
//  Created by Anish Kumar on 2/4/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import "AppDelegate.h"
#import <MPulse/MPulse.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    MPulseSettings* settings;
    [settings setViewGroup:@"Default"]; //group
    
    
    // configure settings at init
    [MPulse initializeWithAPIKey:@"WXGVC-642RA-9Y42X-N32NE-ETSRE"];
    
//    [settings setActionName:@"DefaultAction"];//action
//    [settings setActionTimeout:[NSNumber numberWithInt:240000]]; //4 minutes
//    [settings setMaxActionResources:100];
//    [settings shouldTimeoutToStop];
//    [[MPulse sharedInstance] startActionWithSettings:settings];
    
    [[MPulse sharedInstance] setDimension:@"AppVersion" value:@"1.0.0"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
