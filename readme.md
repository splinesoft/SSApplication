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
    @end
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

1. Kindly tell `SSApplication` about your root view controller, to be added to the main window (which `SSApplication` also creates for you).

    ```objc
    - (UIViewController *) appRootViewController {
    	return [[UINavigationController alloc] initWithRootViewController:
    			[MyViewController new]];
    }
    ```


2. The preferred way of setting up your application at launch time is by implementing the `UIApplicationDelegate` method `application:willFinishLaunchingWithOptions:`, not `application:didFinishLaunchingWithOptions:`.

    As of Xcode 4.6.3, the default project template still gets this wrong. For shame!
    
    `SSApplication` implements `application:willFinishLaunchingWithOptions:` and passes launch arguments to your app delegate:


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

```objc
- (void) receivedApplicationEvent:(SSApplicationEvent)eventType {    
    NSLog(@"Event received: %i", eventType);

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
```

# Example

Check out `Example` for an app example.

# Thanks!

`SSApplication` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))