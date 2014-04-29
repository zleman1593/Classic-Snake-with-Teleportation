//
//  Snake.h
//  leman_Nibbles_2
//
//  Created by Zleman on 11/23/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This class creates and controls the behavior of a snake.

#import <Foundation/Foundation.h>
#import "World.h"
#import "Constants.h"
#import "Queue.h"
#import "Direction.h"


@interface Snake : NSObject
//Designated initializer
- (id) initAtPoint:(CGPoint)point withSize:(int)size growthRate:(int)rate world:(World *)newWorld AutoSnake:(BOOL) autoS;
// Causes snake to move appropriately
- (void) move;
// Causes snake to move forward
- (void) stretch;
// Causes snake to shrink in size
- (void) shrink;
@property (nonatomic) int growthRate;
@property (nonatomic) int size;
@property (nonatomic) int growing;
@property (nonatomic) BOOL dead;
@property (nonatomic) BOOL gameOver;
//Determines whether it can die or not
@property (nonatomic) BOOL autoSnake;
@property (nonatomic) CGPoint startingPoint;
@property (nonatomic) World *world;
@property (nonatomic,strong) Queue *snakeBody;
@property (nonatomic,strong) Direction *direction;
 @end
