//
//  Environment.h
//  Leman_Nibbles
//
//  Created by Zleman on 11/22/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
// This is the view of the program

#import <UIKit/UIKit.h>
#import "Constants.h"
@class Environment;

@protocol EnvironmentDelegate

- (int)contentsOfEnvironment:(Environment *)requestor atPoint:(CGPoint)point;
@property (nonatomic) int level;
@end


@interface Environment : UIView
@property (nonatomic) id <EnvironmentDelegate> delegate;
@end