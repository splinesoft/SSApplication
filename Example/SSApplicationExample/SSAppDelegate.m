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

- (UIViewController *) appRootViewController {
    // Return your root view controller here.
    return [UIViewController new];
}

- (void)receivedApplicationEvent:(SSApplicationEvent)eventType {
    NSLog(@"Received app event: %i", eventType);
    
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
        default:
            break;
    }
}

#pragma mark - other app delegate events

@end
