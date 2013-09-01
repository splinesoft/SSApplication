//
//  SSApplication.m
//  SSApplication
//
//  Created by Jonathan Hersh on 8/31/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSApplication.h"

@interface SSApplication ()
- (void) setupDefaultUserDefaults;
@end

@implementation SSApplication

+ (instancetype)sharedApplication {
    return (SSApplication *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // NSUserDefaults is thread-safe.
        [self setupDefaultUserDefaults];
        
        [self willLaunchBackgroundSetup];
    });
    
    [self willFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [self appRootViewController];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - Setup

- (UIViewController *) appRootViewController {
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

#pragma mark - Default NSUserDefaults

- (NSDictionary *)defaultUserDefaults {
    // override me!
    return @{};
}

- (void)setupDefaultUserDefaults {    
    NSDictionary *defaultUserDefaults = [self defaultUserDefaults];
    
    if( [defaultUserDefaults count] == 0 )
        return;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *prefKeys = [[defaults dictionaryRepresentation] allKeys];
    
    // Set default preferences, but don't overwrite any existing values.
    [defaultUserDefaults enumerateKeysAndObjectsUsingBlock:^(NSString *pref,
                                                             id defaultValue,
                                                             BOOL *stop) {
        if( ![prefKeys containsObject:pref] )
            [defaults setObject:defaultValue
                         forKey:pref];
    }];
    
    // Force a synchronize, though this may not be strictly necessary
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - App Events

- (void)receivedApplicationEvent:(SSApplicationEvent)eventType {
    // override me!
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self receivedApplicationEvent:SSApplicationEventWillEnterForeground];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self receivedApplicationEvent:SSApplicationEventWillTerminate];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self receivedApplicationEvent:SSApplicationEventDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self receivedApplicationEvent:SSApplicationEventWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self receivedApplicationEvent:SSApplicationEventDidEnterBackground];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [self receivedApplicationEvent:SSApplicationEventDidReceiveMemoryWarning];
}

@end
