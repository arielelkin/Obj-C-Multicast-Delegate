//
//  ViewController.m
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//
//

#import "ViewController.h"
#import "Observable.h"
#import "ObserverOne.h"
#import "ObserverTwo.h"

@implementation ViewController {
    Observable *observableThing;

    ObserverOne *anObserver;
    ObserverTwo *anotherObserver;
}

- (void)loadView {
    self.view = [UIView new];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //Instantiate something we'll be observing:
    observableThing = [[Observable alloc] init];

    //Instantiate an object:
    anObserver = [[ObserverOne alloc] init];

    //This object will be a delegate of observableThing:
    [observableThing addDelegate:anObserver];

    //Instantiate another object:
    anotherObserver = [[ObserverTwo alloc] init];

    //which will ALSO be a delegate of observableThing:
    [observableThing addDelegate:anotherObserver];



    //Try this:
    //    [self addAnObjectAsDelegateMultipleTimes];
    //    [self addAnObjectAsDelegateEvenThoughItDoesntConformToProtocol];

}

//You're guaranteed that addDelegate: won't add the
//same instance twice.

-(void) addAnObjectAsDelegateMultipleTimes {
    [observableThing addDelegate:anObserver];
    [observableThing addDelegate:anObserver];
    [observableThing addDelegate:anObserver];
    [observableThing addDelegate:anObserver];
    [observableThing addDelegate:anObserver];
}

// MulticastDelegate checks during runtime if the objects
// you pass to -[MulticastDelegate addDelegate:] conform to the
// protocol you've initialised the MulticastDelegate instance with.
//
// So passing -[MulticastDelegate addDelegate:] an object that doesn't
// conform to it has no effect.

- (void)addAnObjectAsDelegateEvenThoughItDoesntConformToProtocol {
    //    [observableThing addDelegate:self];
}

-(void)observableThingDidSomething
{
    NSLog(@"ViewController got SomeDelegate callback.");
    NSLog(@"It wasn't supposed to.");
}

@end
