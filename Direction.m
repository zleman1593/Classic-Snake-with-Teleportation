//
//  Direction.m
//  leman_Nibbles_2
//
//  Created by Zleman on 11/27/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This class determines the characteristics of the four directions
// and checks to make sure the change in direction is valid.
//It also determines the next point for the creature (i.e snake)
// based on the direction it will next move in.

#import "Direction.h"

@implementation Direction
// Designated Initializer
- (id)initWithX:(int)x y:(int)y{
    if (self = [super init])
    {
        self.direction=CGPointMake(x, y);
    }
    return self;
}
//Updates where the next point should go
- (CGPoint)translatePoint:(CGPoint)point{
    CGPoint newPoint=CGPointMake(point.x +self.direction.x, point.y +self.direction.y);
    return newPoint;
}
//Makes sure directions are not opposite
- (BOOL)isOpposite:(Direction *)dir{
    
    if (dir.direction.x==self.direction.x && dir.direction.y==(-1*self.direction.y)) {
        return YES;
    }
    if (dir.direction.y==self.direction.y && dir.direction.x==(-1*self.direction.x)) {
        return YES;
    }
    
    return NO;
}
@end
