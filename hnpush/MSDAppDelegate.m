//
//  MSDAppDelegate.m
//  hnpush
//
//  Created by Matthew Dobson on 10/12/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "MSDAppDelegate.h"
#import <ApigeeiOSSDK/ApigeeDataClient.h>
#import <ApigeeiOSSDK/ApigeeClientResponse.h>

@implementation MSDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.client = [[ApigeeClient alloc] initWithOrganizationId:@"mdobson" applicationId:@"pushtome-dev"];
    [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    // register device token with App Services (will create the Device entity if it doesn't exist)
    NSLog(@"registering token with app services");
    ApigeeClientResponse *response = [[self.client dataClient] setDevicePushToken:newDeviceToken forNotifier:@"hnpush"];
    
    // you could use this if you log in as an app services user to associate the Device to your User
    //    if (response.transactionState == kUGClientResponseSuccess) {
    //        response = [usergridClient connectEntities: @"users" connectorID: @"me" type: @"devices" connecteeID: deviceId];
    //    }
    
    if (response.transactionState != kApigeeClientResponseSuccess) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:response.error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [view show];
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [view show];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // Received a push notification from the server
    // Only pop alert if applicationState is active (if not, the user already saw the alert)
    if (application.applicationState == UIApplicationStateActive)
    {
        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"New Story!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [view show];
    }
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
