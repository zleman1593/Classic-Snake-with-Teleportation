//
//  Direction.h
//  leman_Nibbles_2
//
//  Created by Zleman on 11/27/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This class determines the characteristics of the four directions
// and checks to make sure the change in direction is valid.
//It also determines the next point for the creature (i.e snake)
// based on the direction it will next move in.

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Direction : NSObject

// Designated Initializer
- (id)initWithX:(int)x y:(int)y;
//Updates where the next point should go
- (CGPoint)translatePoint:(CGPoint)point;
//makes sure directions are not opposite
- (BOOL)isOpposite:(Direction *)dir;
@property (nonatomic) CGPoint direction;
@end
