//
//  Observable.m
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//
//

#import "Observable.h"

@implementation Observable {
    /*
     The delegates we'll be forwarding messages to.
     
     We're holding weak references to them because
     we're not responsible for keeping them alive.
     
     The order in which they'll be invoked is random.
     
     */
    NSHashTable *delegates;
}

-(id)init {
    self = [super init];
    if (self)
    {
        delegates = [NSHashTable weakObjectsHashTable];
        [self startDoingSomething];
    }
    return self;
}

- (void)addDelegate:(id<SomeDelegate>)delegate {
    [delegates addObject:delegate];
}

- (void)removeDelegate:(id<SomeDelegate>)delegate {
    [delegates removeObject:delegate];
}

- (void) startDoingSomething {
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(doSomething)
                                   userInfo:nil
                                    repeats:YES];
}


-(void)doSomething {
    for (id delegate in delegates) {
        [delegate observableThingDidSomething];
    }
//    [self shouldIDoSomething];
}

- (void) shouldIDoSomething {
    for (id delegate in delegates) {
        if ([delegate observableThingShouldDoSomething]) {
            NSLog(@"this delegate tells me to do something");
        } else {
            NSLog(@"this delegate tells me to NOT do something");
        }
    }
}

@end
