//
//  Queue.m
//  
//
//  Created by Eric Chown on 4/4/13.
// Modified by Zackery Leman on 11/20/13
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
// Sets up a queue data structure

#import "Queue.h"

@implementation Queue

@synthesize queue = _queue;

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (id)queue
{
    if (!_queue) _queue = [[List alloc] init];
    return _queue;
}

- (void)enqueue:(CGPoint)anObject
{
    [self.queue addToTail:anObject];
}

- (CGPoint)dequeue
{
    return [self.queue removeFromHead];
}

- (void)clear
{
    [self.queue clear];
}

- (int)size
{
    return [self.queue size];
}

- (CGPoint)peek
{
    return [self.queue getHeadData];
}

- (CGPoint)peekTail
{
    return [self.queue getTailData];
}


- (BOOL)isEmpty
{
    return [self.queue isEmpty];
}

@end
