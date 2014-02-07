//
//  Observable.m
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//
//

#import "Observable.h"

@interface Observable()

@property id<SomeDelegate> delegate;

@end

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

- (void)addDelegate:(id<SomeDelegate>)delegate
{
    [self.multicastDelegate addDelegate:delegate];
}

- (void)removeDelegate:(id<SomeDelegate>)delegate
{
    [self.multicastDelegate removeDelegate:delegate];
}




- (MulticastDelegate *)multicastDelegate
{
    static MulticastDelegate *multicastDelegate = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Protocol *protocol = @protocol(SomeDelegate);
        multicastDelegate = [[MulticastDelegate alloc] initWithProtocol:protocol];
        self.delegate = (id)multicastDelegate;
    });

    return multicastDelegate;
}

-(void)doSomething
{
    [self.delegate observableThingDidSomething];
}

@end
