//
//  SSApplication.h
//  SSApplication
//
//  Created by Jonathan Hersh on 8/31/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSApplication : UIApplication <UIApplicationDelegate>

+ (instancetype) sharedApplication;

@property (nonatomic, strong) UIWindow *window;

#pragma mark - Setup

/**
 * Override me to specify the view controller set for the main window.
 */
- (UIViewController *) appRootViewController;

/**
 * Set up your application at launch. This method runs on the main thread.
 */
- (void) willFinishLaunchingWithOptions:(NSDictionary *)options;

/**
 * This method is called asynchronously on a background queue
 * at the start of `application:willFinishLaunchingWithOptions:`.
 * Any long-running or background setup can go here.
 */
- (void) willLaunchBackgroundSetup;

#pragma mark - Events

typedef NS_ENUM( NSUInteger, SSApplicationEvent ) {
    SSApplicationEventWillEnterForeground,
    SSApplicationEventWillTerminate,
    SSApplicationEventWillResignActive,
    SSApplicationEventDidBecomeActive,
    SSApplicationEventDidEnterBackground,
    SSApplicationEventDidReceiveMemoryWarning,
};

/**
 * This method is called when the delegate receives application events.
 * With this function you can collapse a number of similar implementations into one place.
 */
- (void) receivedApplicationEvent:(SSApplicationEvent)eventType;

@end
