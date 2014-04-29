//
//  World.m
//  leman_Nibbles_2
//
//  Created by Zleman on 11/22/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This class sets up the initial contents of the world
//and keeps track of all of the changes in the world.
//It is able to identify the prescence of a given object/creature at any given point.

#import "World.h"

@implementation World

/* Sets up the current board after a call from the Controller
 */
- (id)init
{
    return [self initWithWidth:WORLD_WIDTH height:(int)WORLD_HEIGHT];
    
}

/* Designated Initializer that initializes a blank world*/
-(id)initWithWidth:(int)w height:(int)h{
   
    if (self = [super init])
    {
        [self setworld:w Height:h];
    }
    return self;
}


/* creates an initial blank world with no contents*/
- (void)setworld:(int)width Height:(int) height{
    NSNumber *empty = @0;
    _world = [[NSMutableArray alloc] initWithCapacity:(height)];
    for (int i = 0; i < height; i++) {
        [_world addObject:[[NSMutableArray alloc] initWithCapacity:width]];
        for (int j = 0; j < width; j++) {
            [[_world objectAtIndex:i] addObject:empty ];
        }
    }
}
/*Places food at a random empty square*/
- (void)placeFood{
    NSNumber *food = @1;
    //NSNumber *empty = @0;
    self.locationOfFood=[self placeItAt:food];
}

/*Places two ends of a wormhole at two random empty points*/
- (void)placeWormHoles{
    NSNumber *wormHole1 = @3;
    NSNumber *wormHole2 = @4;
    self.locationOfWh1=[self placeItAt:wormHole1];
    self.locationOfWh2=[self placeItAt:wormHole2];
    
}

/*Does the work to pick a random empty location
 * and place the object there.
 *Takes the number representing the object and
 *returns where it went */
- (CGPoint)placeItAt:(NSNumber*) placeObject{
    CGPoint temp;
    NSNumber *empty = @0;
    NSNumber *toPlace= placeObject;
    //Generates random numbers
    int x=arc4random_uniform(WORLD_WIDTH);
    int y=arc4random_uniform(WORLD_HEIGHT);
    //Makes sure it keeps picking a random spot that is not already occupied
    while (![empty isEqual:[[self.world objectAtIndex:x] objectAtIndex:y]]) {
        x=arc4random_uniform(WORLD_WIDTH);
        y=arc4random_uniform(WORLD_HEIGHT);
    }
    //Places object at the randomly generated location
    [[self.world objectAtIndex:x] replaceObjectAtIndex:y withObject:toPlace];
    temp=CGPointMake(x,y);
    return temp;
}

/* Returns the center point of world*/
- (CGPoint)getCenter{
    CGPoint point;
    point.x= (int) WORLD_WIDTH/2;
    point.y= (int) WORLD_HEIGHT/2;
    return point;
}
// returns the  a point one unit above the center point of world
- (CGPoint)getCenterOffSet{
    CGPoint point;
    point.x= (int) WORLD_WIDTH/2;
    point.y= (int) WORLD_HEIGHT/2;
    point.x=point.x-5;
    point.y=point.y+5;
    return point;
    
}

// Places the tail of the snake at a point
- (void)placeSnakeAtPoint:(CGPoint)point{
    NSNumber *snake = @2;
    [[self.world objectAtIndex: point.x] replaceObjectAtIndex: point.y withObject:snake];
}

// Returns YES, if food is at the point that it is given
- (BOOL)containsFoodAtPoint:(CGPoint)point{
    NSNumber *food = @1;
    if ([food isEqual:[[self.world objectAtIndex:point.x] objectAtIndex:point.y]]) {
        return YES;
    }
    return NO;
}
// Returns YES, if part of the snake is at the point that it is given
- (BOOL)containsSnakeAtPoint:(CGPoint)point{
    NSNumber *snake = @2;
    
    if ([snake isEqual:[[self.world objectAtIndex:point.x] objectAtIndex:point.y]]) {
        return YES;
    }
    return NO;
    
}
// Returns YES, if a wormhole is at the point that it is given
- (BOOL)containsWormHoleAtPoint:(CGPoint)point{
    NSNumber *wormHole = @3;
    if ([wormHole isEqual:[[self.world objectAtIndex:point.x] objectAtIndex:point.y]]) {
        return YES;
    }
    return NO;
    
}
// Returns YES, if the other end of the wormhole is at the point that it is given
- (BOOL)containsWormHole2AtPoint:(CGPoint)point{
    NSNumber *wormHole = @4;
    if ([wormHole isEqual:[[self.world objectAtIndex:point.x] objectAtIndex:point.y]]) {
        return YES;
    }
    return NO;
    
}

// Removes food from board and calls - (void)placeFood;
- (void)consumeFood{
    NSNumber *empty = @0;
    int x=self.locationOfFood.x;
    int y=self.locationOfFood.y;
    [[self.world objectAtIndex:x] replaceObjectAtIndex:y withObject:empty];
    [self placeFood];
    
}
// Check the legality of point by making sure the point is not off the screen
- (BOOL)outOfBoundsAtPoint:(CGPoint)point{
    if (point.x<=WORLD_WIDTH && point.y<=WORLD_HEIGHT) {
        return YES;
    }
 return  NO;
    
}
// Remove any items/creatures at a given point
- (void)clearPoint:(CGPoint)point{
    NSNumber *empty = @0;
    int x=point.x;
    int y=point.y;
    [[self.world objectAtIndex:x] replaceObjectAtIndex:y withObject:empty];
    
}



@end