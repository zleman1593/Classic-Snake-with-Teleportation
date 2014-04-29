//
//  Snake.m
//  leman_Nibbles_2
//
//  Created by Zleman on 11/23/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This class creates and controls the behavior of a snake.
//Alows for the generation of an snake that cannot die (AutoSnake) in addition to the regular snake
//in harder levels.

#import "Snake.h"


@implementation Snake

- (id) initAtPoint:(CGPoint)point withSize:(int)size growthRate:(int)rate world:(World *)newWorld AutoSnake:(BOOL) autoS{
    
    if (self = [super init])
    {
        self.growthRate = rate;
        self.autoSnake=autoS;
        self.world =newWorld;
        self.startingPoint=point;
        self.growing=0;
        self.size=size;
        self.dead=NO;
        self.gameOver=NO;
        self.snakeBody=[[Queue alloc] init];
        self.direction=nil;
        //places snake at the center of the world
        [self.world placeSnakeAtPoint:point];
        //first part of the body is tracked
        [self.snakeBody enqueue:point];
        //if initial size is greater than one add the rest of the body
        // to the world and track it in the queue
            for (int i=self.size; i>1; i--) {
                CGPoint nextPoint;
                nextPoint=point;
                nextPoint.x= nextPoint.x + ((self.size+1)-i);
                [self.world placeSnakeAtPoint: nextPoint];
                [self.snakeBody enqueue: nextPoint];
            }
    }
    return self;
}

// Causes snake to move appropriately
- (void) move{
    if (self.dead) {
        [self shrink];
    } else {
        [self stretch];
        //allows the snake to grow after consuming food
        if (self.growing==0) {
            [self shrink];
        } else {
            self.growing=self.growing-1;
        }
    }
}

// Causes snake to move forward
- (void) stretch{
    //gets the location of where the head of the snake will be placed next
    CGPoint head =[self.direction translatePoint:[self.snakeBody peekTail]];
    //Checks to see if it will cross it self or run off the world
    if (head.x+1>WORLD_WIDTH||head.y+1>WORLD_HEIGHT||head.x<0||head.y<0||
        [self.world containsSnakeAtPoint:head]==YES) {
        if (!self.autoSnake) {
            self.dead=YES;
        } else{
            //if it is an auto snake it cannot die and simply relocates
            [self.snakeBody enqueue: [self.world locationOfWh2]];
            [self.world placeSnakeAtPoint: [self.world locationOfWh2]];
        }

    } else{
        //Checks to see if it there is food at this next point
        if ([self.world containsFoodAtPoint:head]) {
            self.growing=self.growthRate;
            [self.world consumeFood];
        }
        //Checks to see if it there is a wormhole at this next point
        //If so the head of the snake is placed at the other wormhole location
        if ([self.world containsWormHoleAtPoint:head]) {
            
            [self.snakeBody enqueue: [self.world locationOfWh2]];
            [self.world placeSnakeAtPoint: [self.world locationOfWh2]];
        }
        else if ([self.world containsWormHole2AtPoint:head]) {
            
            [self.snakeBody enqueue: [self.world locationOfWh1]];
            [self.world placeSnakeAtPoint: [self.world locationOfWh1]];
        }
        else{
            [self.snakeBody enqueue:head];
            [self.world placeSnakeAtPoint:head];
        }
    }
}

// Causes snake to shrink in size
- (void) shrink{
    
    CGPoint removeTail=[self.snakeBody dequeue];
    if (removeTail.x==0 && removeTail.y==0) {
        self.gameOver=YES;
    } else{
        [self.world clearPoint:removeTail];
    }
    
}
@end
