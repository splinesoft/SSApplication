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

- (void)ss_willFinishLaunchingWithOptions:(NSDictionary *)options {
    NSLog(@"Standard application setup should go here.");
}

- (void)ss_willLaunchBackgroundSetup {
    if ([NSThread isMainThread]) {
        // this will never happen
        exit(1);
    } else {
        NSLog(@"This setup is not on the main thread!");
    }
}

- (UIViewController *) ss_appRootViewController {
    // Create a default view controller here.
    return [UIViewController new];
}

- (void)ss_receivedApplicationEvent:(SSApplicationEvent)eventType {
    NSLog(@"Received app event: %@", @(eventType));
    
    switch( eventType ) {
        case SSApplicationEventDidBecomeActive:
        case SSApplicationEventWillEnterForeground:
            
            // here I might start up an analytics service
            break;
            
        case SSApplicationEventDidEnterBackground:
        case SSApplicationEventWillResignActive:
            
            // here I might shut down an analytics service
            break;
            
        case SSApplicationEventWillTerminate:
            
            // here I might clean up core data
            break;
            
        case SSApplicationEventDidReceiveMemoryWarning:
            
            // memory warning!
            break;
            
        default:
            
            break;
    }
}

- (NSDictionary *) ss_defaultUserDefaults {
    return @{
        @"A-Preference-With-A-Default-Value" : @1337
    };
}

@end
