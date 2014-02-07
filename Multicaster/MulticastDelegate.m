//
//  MulticastDelegate.m
//  Multicaster
//
//  Created by Ariel Elkin on 28/01/2014.
//
//

#import "MulticastDelegate.h"
#import <objc/runtime.h>

@implementation MulticastDelegate
{
    /* 
     The delegates we'll be forwarding messages to.

     We're holding weak references to them because
     we're not responsible for keeping them alive.

     The order in which they'll be invoked is random.

     */
    NSHashTable *_delegates;


    /*
     The protocol our delegates are conforming to:

     */
    Protocol *_protocol;
}

- (id)initWithProtocol:(Protocol *)protocol
{
    if (self = [super init])
    {
        _delegates = [NSHashTable weakObjectsHashTable];
        _protocol = protocol;

        //Problem:

        //if protocol argument is nil, then MulticastDelegate is
        //expected to respond to delegate callbacks.
        //However, -[MulticastDelegate forwardInvocation:] doesn't get
        //called in that case, and the app crashes because
        //this check isn't made:
        //([delegate respondsToSelector:[anInvocation selector]])

    }
    return self;
}

- (void)addDelegate:(id)delegate
{
    if ([delegate conformsToProtocol:_protocol])
    {
        [_delegates addObject:delegate];
    }
    else
    {
        NSLog(@"%s: Can't add a %@ to my delegates as it doesn't conform to %@ protocol.", __FUNCTION__, [delegate class], NSStringFromProtocol(_protocol));
    }
}

- (void) removeDelegate:(id)delegate
{
    [_delegates removeObject:delegate];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    if ([super conformsToProtocol:aProtocol])
        return YES;

    // if any of the delegates conform to this protocol, return YES
    for(id delegate in _delegates)
    {
        if ([delegate conformsToProtocol:aProtocol])
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;

    // if any of the delegates respond to this selector, return YES
    for(id delegate in _delegates)
    {
        if ([delegate respondsToSelector:aSelector])
        {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{

    //Check the delegates' method signature for that selector:
    for(id delegate in _delegates)
    {
        if ([delegate respondsToSelector:aSelector])
        {
            return [delegate methodSignatureForSelector:aSelector];
        }
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // forward the invocation to every delegate:
    for(id delegate in _delegates)
    {
        if ([delegate respondsToSelector:[anInvocation selector]])
        {
            [anInvocation invokeWithTarget:delegate];
        }
    }
}

@end
