//
//  AppDelegate.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/10/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize passengerList;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    passengerList = [[NSMutableArray alloc] init];
    
    return YES;
}


-(NSString *)createName:(int) group {
    
    NSMutableArray *prefix = [[NSMutableArray alloc] init];
    [prefix addObject:@"Red"];
    [prefix addObject:@"Blue"];
    [prefix addObject:@"Pink"];
    [prefix addObject:@"Lavendar"];
    [prefix addObject:@"Rose"];
    [prefix addObject:@"Yellow"];
    [prefix addObject:@"Brown"];
    [prefix addObject:@"Green"];
    
    NSMutableArray *lastName = [[NSMutableArray alloc] init];
    [lastName addObject:@"Apple"];
    [lastName addObject:@"Kiwi"];
    [lastName addObject:@"Sun"];
    [lastName addObject:@"Star"];
    [lastName addObject:@"Leaf"];
    [lastName addObject:@"Tooth"];
    [lastName addObject:@"Rock"];
    [lastName addObject:@"Eagle"];
    [lastName addObject:@"Hawk"];
    
    int value1 = arc4random() % 8;
    int value2 = arc4random() % 9;
    NSString *name = [NSString stringWithFormat:@"%@-%@%d", [prefix objectAtIndex:value1], [lastName objectAtIndex:value2], group];
    return name;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
