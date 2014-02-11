//
//  Observable.m
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//
//

#import "Observable.h"

@implementation Observable

-(id)init
{
    self = [super init];
    if (self)
    {
        [self startDoingSomething];
    }

    return self;
}

- (void) startDoingSomething
{
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(doSomething)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)doSomething
{
    [[self multicastDelegate] observableThingDidSomething];
}

- (MulticastDelegate *)multicastDelegate
{
    static MulticastDelegate *multicastDelegate = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        multicastDelegate = [[MulticastDelegate alloc] initWithProtocol:@protocol(SomeDelegate)];
    });

    return multicastDelegate;
}


/*
 There's two ways of using MulticastDelegate:
 
 A) In your header, declare a MulticastDelegate property that conforms to
 the relevant protocol. Then write a static singleton setter method for 
 it, such as the above, in which you initialize it with the relevant protocol.
 
 B) Create addDelegate: and removeDelegate: methods that take in an
 object that should conform to the protocol, and which then pass it 
 to -[MulticastDelegate addDelegate:] or -[MulticastDelegate removeDelegate:].
 This ensures a compile-time check that the delegate objects conform to the
 protocol.

 */

- (void)addDelegate:(id<SomeDelegate>)delegate
{
    [self.multicastDelegate addDelegate:delegate];
}

- (void)removeDelegate:(id<SomeDelegate>)delegate
{
    [self.multicastDelegate removeDelegate:delegate];
}


@end
