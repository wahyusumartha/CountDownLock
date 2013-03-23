//
//  CountDownLock.m
//
//  Copyright (c) 2012 John J. Fowler
//
/*
 Copyright 2012 John J. Fowler
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "CountDownLock.h"

@implementation CountDownLock

@synthesize count;

-(id)initWithCount:(int)initialCount {
  if (self=[super init]) {
    
    qName = [NSString stringWithFormat:@"com.somewhere.CountDownLock-%d",arc4random()];
    theQ = dispatch_queue_create([qName UTF8String], 0);
    dispatch_sync(theQ, ^{
      count=initialCount;
    });
  }
  return self;
}

-(void)countDown {
  dispatch_sync(theQ, ^{
    count--;
  });
}

-(void)await {
  __block BOOL result=true;
  while(result) {
    dispatch_sync(theQ, ^{
      result=count>0;
    });
    sleep(0.1);
  }
}

-(void)awaitTilCount:(int)desiredCount {
  __block BOOL result=true;
  while(result) {
    dispatch_sync(theQ, ^{
      result=count>0;
    });
    sleep(0.1);
  }
}

@end
