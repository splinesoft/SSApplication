//
//  SSAppDelegate.m
//  SSApplicationExample
//
//  Created by Jonathan Hersh on 8/31/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSAppDelegate.h"

@implementation SSAppDelegate

#pragma mark - SSApplication

- (void)willFinishLaunchingWithOptions:(NSDictionary *)options {
    NSLog(@"Standard application setup should go here.");
}

- (void)willLaunchBackgroundSetup {
    if( [NSThread isMainThread] ) {
        // this will never happen
    } else {
        NSLog(@"This setup is not on the main thread!");
    }
}

- (UIViewController *)rootViewController {
    // Return your root view controller here.
    return [UIViewController new];
}

- (void)receivedApplicationEvent:(NSString *)eventType {
    NSLog(@"Received app event: %@", eventType);
    
    if( [eventType isEqualToString:UIApplicationWillEnterForegroundNotification]
       || [eventType isEqualToString:UIApplicationDidBecomeActiveNotification] ) {
        
        // here I generally do things like start up analytics
    }
    
    if( [eventType isEqualToString:UIApplicationWillResignActiveNotification]
       || [eventType isEqualToString:UIApplicationWillTerminateNotification]
       || [eventType isEqualToString:UIApplicationDidEnterBackgroundNotification] ) {
        
        // Here I generally do things like shut down analytics, clean up core data, etc
        
        
    }
}

#pragma mark - other app delegate events

@end
