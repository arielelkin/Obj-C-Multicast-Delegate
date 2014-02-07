//
//  MulticastDelegate.h
//  Multicaster
//
//  Created by Ariel Elkin on 28/01/2014.
//
//

/*
 * Generic multicast delegate that can forward messages to
 * more than one object.
 * 
 * Add it as a property.
 *
 * SDSFMulticastDelegate keeps weak references its delegates. 
 *
 * Based on:
 * http://www.scottlogic.com/blog/2012/11/19/a-multicast-delegate-pattern-for-ios-controls.html
 *
 */

#import <Foundation/Foundation.h>

@interface MulticastDelegate : NSObject

- (id)initWithProtocol:(Protocol *)protocol;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end

    //Multicasting: send (data) across a computer network to several users at the same time.
//advantages of multicast delegate:
//no overhead associated with NSNotificationCenter

//If you register yourself multiple times for the exact specific notification, NSNotificationCenter will NOT recognize the redundancy and instead will fire off as many notifications to you as you've registered an observation for.
//This is almost never the behavior you want to see and is almost always accidental.
//This means you have to worry about cleaning up your observers.

//why should delegates only talk to one object? doesn't make sense.

//NSNotificationCentre makes sense for app-wide notifications
//Use notifications if you want to tell everyone that something has happened. For example in low memory situations a notification is sent telling your app that there has been a memory warning. Because lots of objects in your app might want to lower their memory usage it's a notification.

//NSNotificationCentre makes absolutely no compile-time or runtime checks that contracts are respected.

//NSNotificationCentre is an opaque motherfucker, this makes it very hard to debug. You have no clue who's listening to what. With this delegate, you can at any time figure out who's listening to what.

//NSNotifications are not made for passing elaborate data around. You have to shove all your important data in the userInfo dictionary, and now you have to keep track of keys too!

//"Before an object that is observing notifications is deallocated, it must tell the notification center to stop sending it notifications. Otherwise, the next notification gets sent to a nonexistent object and the program crashes." What? Why the hell should NSNotificationCenter keep a strong reference to observers?? Fuck this shit!

//This means you have to worry about queues
//https://code.google.com/r/riky-adsfasfasf/source/browse/Utilities/GCDMulticastDelegate.h

//This means you can't dynamically add delegates
//https://github.com/lukabernardi/LBDelegateMatrioska/blob/master/LBDelegateMatrioska/LBDelegateMatrioska.h

//NSNotificationCenter is good to send and receive notifications that could affect every single class in your app. System-wide stuff such as:
/*
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(applicationDidEnterBackground:)
 name:UIApplicationDidEnterBackgroundNotification
 object:nil];
 
 - (void) applicationDidEnterBackground:(UIApplication *)application
 {
 // Closes the database connection to reduce the backgound memory footprint
 [[KDDatabaseAccess sharedDatabaseAccess] closeDatabase];

 }
 
 //The delegate pattern is better for multicasting because the contract is explicit. The contract is too implicit with NSNotificationCenter.


 //They have them in C# (http://msdn.microsoft.com/en-us/library/system.multicastdelegate(v=vs.110).aspx)


*/