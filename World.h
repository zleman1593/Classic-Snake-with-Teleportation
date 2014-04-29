//
//  World.h
//  leman_Nibbles_2
//
//  Created by Zleman on 11/22/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This class sets up the initial contents of the world
//and keeps track of all of the changes in the world.
//It is able to identify the prescence of a given object/creature at any given point.

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface World : NSObject

// Designated Initializer
- (id)initWithWidth:(int)w height:(int)h;
// Places food at a random empty square
- (void)placeFood;
// returns the center point of world
- (CGPoint)getCenter;
// returns the  a point one unit above the center point of world
- (CGPoint)getCenterOffSet;


// Places the tail of the snake at a point
- (void)placeSnakeAtPoint:(CGPoint)point;
// Places two ends of a wormhole at two random empty points
- (void)placeWormHoles;
// Removes food from board and calls - (void)placeFood;
- (void)consumeFood;

// Returns YES, if food is at the point that it is given
- (BOOL)containsFoodAtPoint:(CGPoint)point;
// Returns YES, if part of the snake is at the point that it is given
- (BOOL)containsSnakeAtPoint:(CGPoint)point;
// Returns YES, if a wormhole is at the point that it is given
- (BOOL)containsWormHoleAtPoint:(CGPoint)point;
// Returns YES, if the other end of the wormhole is at the point that it is given
- (BOOL)containsWormHole2AtPoint:(CGPoint)point;
// Check the legality of point by making sure the point is not off the screen
- (BOOL)outOfBoundsAtPoint:(CGPoint)point;
// Remove any items/creatures at a given point
- (void)clearPoint:(CGPoint)point;


@property (strong, nonatomic) NSMutableArray *world;
@property (nonatomic) CGPoint locationOfFood;
@property (nonatomic) CGPoint locationOfWh1;
@property (nonatomic) CGPoint locationOfWh2;
@end
