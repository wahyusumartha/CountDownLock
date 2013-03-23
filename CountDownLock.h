//
//  CountDownLock.h
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


#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

@interface CountDownLock : NSObject {
  NSLock *theLock;
  dispatch_queue_t theQ;
  NSString *qName;
}

@property (nonatomic,readonly) int count;

-(id)initWithCount:(int)initialCount;
-(void)countDown;
-(void)await;
-(void)awaitTilCount:(int)desiredCount;
@end
