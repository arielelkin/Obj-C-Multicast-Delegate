//
//  ObserverTwo.m
//  Multicaster
//
//  Created by Ariel Elkin on 07/02/2014.
//  Copyright (c) 2014 Saffron Digital. All rights reserved.
//

#import "ObserverTwo.h"

@implementation ObserverTwo

-(void)observableThingDidSomething
{
    NSLog(@"Observer Two instance got SomeDelegate callback");
}

@end
