//
//  ViewController.m
//  leman_Nibbles_2
//
//  Created by Zleman on 11/22/13.
//  Copyright (c) 2013 Zleman. All rights reserved.
//This is the view controller that sets up the game and controls the game play.

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // sets the current level
    self.level =1;
    // Sets delegate
    self.environmentView.delegate = self;
    // Creates a new world
    self.theWorld = [[World alloc] init];
    
    self.snake = [[Snake alloc] initAtPoint:[self.theWorld getCenter] withSize:4 growthRate:1 world:self.theWorld AutoSnake:NO ];
    //Creates direction objects
    self.up = [[Direction alloc] initWithX:0 y:-1];
    self.down = [[Direction alloc] initWithX:0 y:1];
    self.left = [[Direction alloc] initWithX:-1 y:0];
    self.right = [[Direction alloc] initWithX:1 y:0];
    self.snake.direction=[[Direction alloc] initWithX:1 y:0];
    //updates display
    [self.theWorld placeFood];
    [self.theWorld placeWormHoles];
    [self.view setNeedsDisplay];
	
}

//Sets up a new game with specific characteristics for the given level. Similar to above method
-(void)updateLevelDataWithLevel:(int)levelNumber SizeIncrement:(int)size GRIncrement:(int)Gr Timertime:(double)timer Autosnake:(BOOL) autosnake{
    //Stops the timer
    [self.timer invalidate];
    // sets the current level
    self.level=levelNumber;
    //Stops the end of game animation
    [self.endOfGame stopAnimating];
    //Resets the game over text
    [self.gameOverLabel setText:@""];
    // Creates a new world
    self.theWorld = [[World alloc] init];
    //Creates the snake
    self.snake = [[Snake alloc] initAtPoint:[self.theWorld getCenter] withSize:INITIAL_SNAKE_SIZE-size growthRate:GROWTH_RATE-Gr world:self.theWorld AutoSnake:NO];
    // Sets the initial direction of the snake
    self.snake.direction=[[Direction alloc] initWithX:1 y:0];
    //Starts the timer so that the game will begin and the snake will move
    //If the level requires an autonomous snake, the appropriate method is called
    if (autosnake) {
        [self autoSnakeMethod];
    }
    //Places food in the world
    [self.theWorld placeFood];
    //Places two worm holes in the world
    [self.theWorld placeWormHoles];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timer
                                                  target:self
                                                selector:@selector(updateWorld)
                                                userInfo:nil
                                                 repeats:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Upon a button press, the method checks to see if the button press was valid.
//If it was it updates the direction the snake is moving in.
- (IBAction)up:(id)sender {
    NSLog(@"digit pressed is up");
    if (![self.up isOpposite:[self.snake direction]]) {
        self.snake.direction.direction=[self.up direction];
    }
    //second commands are for the autoSnake (ememy )
    if (![self.down isOpposite:[self.autoSnake direction]]) {
        self.autoSnake.direction.direction=[self.down direction];
    }
}

- (IBAction)right:(UIButton *)sender {
    NSLog(@"digit pressed is right");
    if (![self.right isOpposite:[self.snake direction]]) {
        self.snake.direction.direction=[self.right direction];
    }
    
    if (![self.left isOpposite:[self.autoSnake direction]]) {
        self.autoSnake.direction.direction=[self.left direction];
    }

}

- (IBAction)down:(UIButton *)sender {
    NSLog(@"digit pressed is down");
    if (![self.down isOpposite:[self.snake direction]]) {
        self.snake.direction.direction=[self.down direction];
    }
    if (![self.up isOpposite:[self.autoSnake direction]]) {
        self.autoSnake.direction.direction=[self.up direction];
    }
}

- (IBAction)left:(UIButton *)sender {
    NSLog(@"digit pressed is left");
    if (![self.left isOpposite:[self.snake direction]]) {
        self.snake.direction.direction=[self.left direction];
    }
    
    if (![self.right isOpposite:[self.autoSnake direction]]) {
        self.autoSnake.direction.direction=[self.right direction];
    }

}


// Increases the number of wormholes in the game
- (IBAction)wormHoleNumber:(UIStepper *)sender {
    [self.theWorld placeWormHoles];
}

//Starts the first game and starts after a pause without resetting
- (IBAction)start:(UIButton *)sender {
    double speed=SPEED_SLOW;
    if (self.level==2) {
        speed=SPEED_MEDIUM;
    } else if (self.level==3){
        speed=SPEED_FAST;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:speed
                                                  target:self
                                                selector:@selector(updateWorld)
                                                userInfo:nil
                                                 repeats:YES];
}
//pauses the game
- (IBAction)pause:(UIButton *)sender {
    [self.timer invalidate];
}

// Each of these responds to a press of a level button and calls
// the update level method with the given parameters for a certain difficulty
- (IBAction)easy:(UIButton *)sender {
    [self updateLevelDataWithLevel:LEVEL_EASY SizeIncrement:0 GRIncrement:0 Timertime:0.25 Autosnake:NO];
}
- (IBAction)medium:(UIButton *)sender {

    [self updateLevelDataWithLevel:LEVEL_MEDIUM SizeIncrement:1 GRIncrement:1 Timertime:0.15 Autosnake:YES];

}

- (IBAction)hard:(UIButton *)sender {
    [self updateLevelDataWithLevel:LEVEL_HARD SizeIncrement:2 GRIncrement:2 Timertime:0.08 Autosnake:YES];
}



//Takes a CGPoint determines what is at that location
//and returns the contents of that location
- (int)contentsOfEnvironment:(Environment *)requestor atPoint:(CGPoint)point{
    int number=[[[[self.theWorld world] objectAtIndex:point.x] objectAtIndex:point.y] intValue];
    return number;
    
}
// Calls snake to move and then updates the world
// to reflect movement
- (void)updateWorld{
    //Snakes is called to move once in its current direction
    [self.snake move];
    [self.autoSnake move];
    //If the game is over
    if (self.snake.gameOver==YES) {
        [self.timer invalidate];
        [self.endOfGame startAnimating];
        [self.gameOverLabel setText:@"Game OVER"];
    }
    //Refreshes the visible world
    [self.environmentView setNeedsDisplay];
    
}

//sets up an autoSnake
-(void)autoSnakeMethod{
    self.autoSnake = [[Snake alloc] initAtPoint:[self.theWorld getCenterOffSet] withSize:6 growthRate:1 world:self.theWorld AutoSnake:YES];
    self.autoSnake.direction=[[Direction alloc] initWithX:-1 y:-1];
}


@end