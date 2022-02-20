//
//  NSTimer+Time.h
//  Encapsulation
//
//  Created by SSR on 2022/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Timer)

/**加入到runloop*/
- (void)begin;

/**创建后立刻开始执行*/
+ (NSTimer *)beginWithTimer:(NSTimer *)timer;

/**停止，返回自己，建议 = nil*/
- (void)end;

@end

NS_ASSUME_NONNULL_END
