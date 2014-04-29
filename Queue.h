//
//  Queue.h
//  
//
//  Created by Eric Chown on 4/4/13.
// Modified by Zackery Leman on 11/20/13
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
// Sets up a queue data structure

#import <Foundation/Foundation.h>
#import "List.h"

@interface Queue : NSObject

@property (nonatomic, strong) List *queue;

- (id)init;
- (void)enqueue:(CGPoint)anObject;
- (CGPoint)dequeue;
- (void)clear;
- (int)size;
- (CGPoint)peek;
- (CGPoint)peekTail;
- (BOOL)isEmpty;

@end
