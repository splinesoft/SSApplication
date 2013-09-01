//
//  SSApplication.m
//  SSApplication
//
//  Created by Jonathan Hersh on 8/31/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSApplication.h"

@implementation SSApplication

+ (instancetype)sharedApplication {
    return (SSApplication *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self willLaunchBackgroundSetup];
    });
    
    [self willFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [self rootViewController];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - Setup

- (UIViewController *)rootViewController {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:
                                           @"Did you forget to override %@?",
                                           NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)willFinishLaunchingWithOptions:(NSDictionary *)options {
    // override me!
}

- (void)willLaunchBackgroundSetup {
    // override me!
}

#pragma mark - App Events

- (void)receivedApplicationEvent:(NSString *)eventType {
    // override me!
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self receivedApplicationEvent:UIApplicationWillEnterForegroundNotification];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self receivedApplicationEvent:UIApplicationWillTerminateNotification];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self receivedApplicationEvent:UIApplicationDidBecomeActiveNotification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self receivedApplicationEvent:UIApplicationWillResignActiveNotification];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self receivedApplicationEvent:UIApplicationDidEnterBackgroundNotification];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [self receivedApplicationEvent:UIApplicationDidReceiveMemoryWarningNotification];
}

@end
