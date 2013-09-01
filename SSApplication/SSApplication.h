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

#pragma mark - Default NSUserDefaults

/**
 * A handy way to set up default values in NSUserDefaults.
 * Each key in the dictionary you specify is checked against the keys
 * already in NSUserDefaults, and any existing keys will NOT be overwritten.
 * This allows you to specify defaults for user preferences and 
 * not overwrite any changes the user has made to those preferences.
 * It also allows you to, perhaps in an update, introduce new preferences
 * without having to worry about overwriting values in older preferences.
 *
 * Each key is the name of a preference, each object is the default value for that pref.
 */
- (NSDictionary *) defaultUserDefaults;

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
