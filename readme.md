# SSApplication

[![Build Status](https://travis-ci.org/splinesoft/SSApplication.png?branch=master)](https://travis-ci.org/splinesoft/SSApplication)

A `UIApplication` subclass to start your app off right.

`SSApplication` powers launch setup and app notifications in my app [MUDRammer - A Modern MUD Client for iPhone and iPad](https://itunes.apple.com/us/app/mudrammer-a-modern-mud-client/id597157072?mt=8).

# Setup

1. Install with [Cocoapods](http://cocoapods.org/). Add to your Podfile:

    ```
    pod 'SSApplication', :head # YOLO
    ```
    
    Or just drag `SSApplication.{h,m}` into your project.

2. With `SSApplication` installed, edit your main app delegate file and subclass `SSApplication`:

    ```objc
    // MyAppDelegate.h
    #import <SSApplication.h>

    @interface MyAppDelegate : SSApplication
    ```

3. You'll need to make a small change in your app's `main.m` file to tell it about your new principal `UIApplication` subclass. Add your app delegate's class as the third argument to `UIApplicationMain`. Your `main.m` should look something like this:

    ```objc
    // main.m
    #import <UIKit/UIKit.h>
    #import "MyAppDelegate.h"

    int main(int argc, char *argv[])
    {
        @autoreleasepool {
            return UIApplicationMain(argc, 
                                     argv, 
                                     NSStringFromClass([MyAppDelegate class]), 
                                     NSStringFromClass([MyAppDelegate class]));
        }
    }
    ```

# App Launch

`SSApplication` helps you set up your app at launch time by providing several methods you should override in your `SSApplication` subclass.

The preferred way of setting up your application at launch time is by implementing the `UIApplicationDelegate` method `application:willFinishLaunchingWithOptions:`, not `application:didFinishLaunchingWithOptions:`.

As of Xcode 4.6.3, the default project template still gets this wrong. For shame!

1. Kindly tell `SSApplication` about your root view controller, which will be added to the main window (which `SSApplication` also creates for you).

    ```objc
    - (UIViewController *) rootViewController {
    	return [[UINavigationController alloc] initWithRootViewController:
    			[[MyViewController alloc] init]];
    }
    ```


2. `SSApplication` asks if there's anything to do on the main thread at launch time:

    ```objc
    - (void) willFinishLaunchingWithOptions:(NSDictionary *)options {
     
        // Here I start analytics or other third party services
    }
    ```

3. `SSApplication` asks if there's any long-running setup to be performed on a background queue.

    ```objc
    - (void) willLaunchBackgroundSetup {
        // This method is called asynchronously
        // on a background queue.
        
        // Here I do long-running setup
        // that doesn't need to finish immediately
    }
    ```

# Notifications

The `UIApplicationDelegate` protocol informs your app delegate of a number of important app events, like moving between the background and foreground.

With `SSApplication`, several of these delegate calls are collapsed into a single method you can override.

`SSApplication` takes advantage of the fact that each of these delegate calls has a corresponding notification constant, and calls your method with one of these constants:

```objc
UIApplicationWillEnterForegroundNotification
UIApplicationWillTerminateNotification
UIApplicationWillResignActiveNotification
UIApplicationDidBecomeActiveNotification
UIApplicationDidEnterBackgroundNotification
UIApplicationDidReceiveMemoryWarningNotification
```

```objc
- (void) receivedApplicationEvent:(NSString *)eventType {    
    NSLog(@"Event received: %@", eventType);

    if( [eventType isEqualToString:UIApplicationDidEnterBackgroundNotification]
        || [eventType isEqualToString:UIApplicationWillResignActiveNotification] ) {
        
        // here I shut down my analytics services
    }
    
    if( [eventType isEqualToString:UIApplicationWillEnterForegroundNotification] ) {
        
        // we're back in the foreground!
    }

    if( [eventType isEqualToString:UIApplicationWillTerminateNotification] ) {
        
        // About to terminate!
        // Here I clean up core data and do other shutdown stuff
    }
}
```

# Example

Check out `Example` for an app example.

# Thanks!

`SSApplication` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))