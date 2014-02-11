//
//  Observable.h
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//  
//

#import <Foundation/Foundation.h>
#import "MulticastDelegate.h"

@protocol SomeDelegate <NSObject>

-(void)observableThingDidSomething;

@end

@interface Observable : NSObject

@property (nonatomic, readonly) MulticastDelegate<SomeDelegate> *multicastDelegate;

@end
