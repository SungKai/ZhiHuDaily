//
//  NSTimer+Time.m
//  Encapsulation
//
//  Created by SSR on 2022/2/16.
//

#import "NSTimer+Time.h"

@implementation NSTimer (Time)

/**加入到runloop*/
- (void)begin {
    [NSRunLoop.currentRunLoop addTimer:self forMode:NSRunLoopCommonModes];
}

/**创建后立刻开始执行*/
+ (NSTimer *)beginWithTimer:(NSTimer *)timer {
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timer;
}

/**停止，返回自己，建议 = nil*/
- (void)end {
    [self invalidate];
}

@end
