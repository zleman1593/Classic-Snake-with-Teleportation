//
//  Environment.m
//  Leman_Nibbles
//
//  Created by Zleman on 11/22/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This is the view of the program that draws world and fills in the objects



#import "Environment.h"

@implementation Environment

//Designated initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    int fieldWidth=WORLD_WIDTH;
    int fieldHeight=WORLD_HEIGHT;
    CGPoint temp;
    // This draws the field and colors in the appropriate spaces to
    //represent and object in the world
    for (int i = 0; i < fieldWidth; i++) {
        for (int j = 0; j < fieldHeight; j++) {
            int x = FIELDINSET + i * CELLSIZE;
            int y = FIELDINSET + j * CELLSIZE;
            CGRect rectangle = CGRectMake(x,y,CELLSIZE,CELLSIZE);
            
            temp.x = i;
            temp.y = j;
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextBeginPath(context);
            CGContextStrokePath(context);
            //If level hard is selected then do not draw grid of the world
            if (self.delegate.level!=LEVEL_HARD) {
                CGContextStrokeRect(context, rectangle);
            }
            //Determines what is at a give location and colors the location appropriately
            switch ([self.delegate contentsOfEnvironment:self atPoint:temp]) {
                case 0:
                    break;
                case SNAKE:
                    CGContextSetRGBFillColor(context,1.0,0.0, 0.0, 1.0);
                    CGContextFillRect(context, rectangle);
                    
                    break;
                case FOOD:
                    CGContextSetRGBFillColor(context,0.0,1.0, 0.0, 1.0);
                    CGContextFillRect(context, rectangle);
                    
                    break;
                case PORTAL1:
                    CGContextSetRGBFillColor(context,0.0,0.0, 1.0, 1.0);
                    CGContextFillRect(context, rectangle);
                    
                    break;
                case PORTAL2:
                    CGContextSetRGBFillColor(context,0.0,0.0, 1.0, 1.0);
                    CGContextFillRect(context, rectangle);
                    
                    break;
                default:
                    break;
            }
            
        }
    }
}


@end