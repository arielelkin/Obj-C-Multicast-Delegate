//
//  ObserverOne.m
//  Multicaster
//
//  Created by Ariel Elkin on 28/01/2014.
//
//

#import "ObserverOne.h"

@implementation ObserverOne

-(void)observableThingDidSomething
{
    NSLog(@"Observer One instance got SomeDelegate callback");
}

@end
