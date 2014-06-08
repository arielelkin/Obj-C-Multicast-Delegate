//
//  Observable.h
//  Multicaster
//
//  Created by Ariel Elkin on 27/01/2014.
//  
//

#import <Foundation/Foundation.h>

@protocol SomeDelegate <NSObject>

-(void)observableThingDidSomething;

@optional
-(BOOL)observableThingShouldDoSomething;

@end

@interface Observable : NSObject

- (void)addDelegate:(id<SomeDelegate>)delegate;
- (void)removeDelegate:(id<SomeDelegate>)delegate;

@end
