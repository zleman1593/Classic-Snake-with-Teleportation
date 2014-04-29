//
//  List.m
//
//
//  Created by Eric Chown on 4/4/13.
// Modified by Zackery Leman on 11/20/13
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
//Sets up the list data structure 
//The only change from what you provided with us was forcing the data to be a CGPoint

#import "List.h"

@implementation List

@synthesize tail = _tail;
@synthesize head = _head;
@synthesize count = _count;

- (id)init
{
    if (self = [super init]) {
        self.count = 0;
        self.head = NULL;
        self.tail = NULL;
    }
    return self;
}

- (void)addToHead:(CGPoint)anObject
{
    Node *temp = [[Node alloc] init];
    temp.data = anObject;
    temp.next = self.head;
    self.head = temp;
    if (self.count == 0) {
        self.tail = temp;
    }
    self.count++;
}

- (void)addToTail:(CGPoint)anObject
{
    Node *temp = [[Node alloc] init];
    temp.data = anObject;
    temp.next = nil;
    self.tail.next = temp;
    self.tail = temp;
    if (self.count == 0) {
        self.head = temp;
    }
    self.count++;
}

- (CGPoint)removeFromHead
{
    CGPoint object = self.head.data;
    if (self.count == 1) {
        self.tail = nil;
    }
    if (self.count > 0) {
        self.count--;
    }
    self.head = self.head.next;
    return object;
}

- (CGPoint)removeFromTail
{
    CGPoint temp = self.tail.data;
    Node *finger = self.head;
    while (finger.next.next) {
        finger = finger.next;
    }
    self.tail = finger;
    self.tail.next = nil;
    if (self.count > 1) {
        self.count--;
    } else {
        self.count = 0;
        self.head = nil;
        self.tail = nil;
    }
    return temp;
}

- (CGPoint)getHeadData
{
    return self.head.data;
}

- (CGPoint)getTailData
{
    return self.tail.data;
}

- (void)clear
{
    self.head = nil;
    self.tail    = nil;
    self.count = 0;
}

- (int)size
{
    return self.count;
}

- (BOOL)isEmpty
{
    return self.count == 0;
}



@end
