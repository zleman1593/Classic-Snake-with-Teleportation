//
//  ViewController.h
//  leman_Nibbles_2
//
//  Created by Zleman on 11/22/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
//This is the view controller that sets up the game and controls the game play.

#import <UIKit/UIKit.h>
#import  "Environment.h"
#import "Constants.h"
#import "World.h"
#import"Snake.h"
#import "Direction.h"
@interface ViewController : UIViewController <EnvironmentDelegate>

@property (strong, nonatomic) World *theWorld;
@property (strong, nonatomic) Snake *snake;
@property (strong, nonatomic) Snake *autoSnake;
@property (weak, nonatomic) IBOutlet Environment *environmentView;
@property (strong, nonatomic) Direction *up;
@property (strong, nonatomic) Direction *down;
@property (strong, nonatomic) Direction *left;
@property (strong, nonatomic) Direction *right;
@property (nonatomic) int level;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *endOfGame;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;


//Takes a CGPoint determines what is at that location
//and returns the contents of that location
- (int)contentsOfEnvironment:(Environment *)requestor atPoint:(CGPoint)point;
- (void)updateWorld;

//Responds to button presses
- (IBAction)up:(UIButton *)sender;
- (IBAction)right:(UIButton *)sender;
- (IBAction)down:(UIButton *)sender;
- (IBAction)left:(UIButton *)sender;

//Responds to what level of difficulty is desired
- (IBAction)easy:(UIButton *)sender;
- (IBAction)medium:(UIButton *)sender;
- (IBAction)hard:(UIButton *)sender;


//Adds more wormholes
- (IBAction)wormHoleNumber:(UIStepper *)sender;
//Starts the first game and starts after a pause without resetting
- (IBAction)start:(UIButton *)sender;
//pauses the game
- (IBAction)pause:(UIButton *)sender;
@end
