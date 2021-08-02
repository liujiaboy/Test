//
//  Person.m
//  Thread-GCD
//
//  Created by Alan on 2021/7/28.
//

#import "Person.h"
#import "WeakTimerProxy.h"

#import <UIKit/UIKit.h>

static NSInteger k_abacsd = 0;

@interface Person ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation Person

- (void)dealloc
{
    NSLog(@"%s", __func__);
//    [self.timer invalidate];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)displayLinkTimer {
    
    // 会造成强引用，不会释放
//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTimerRun)];
//    self.displayLink.preferredFramesPerSecond = 1;
//    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    WeakTimerProxy *proxy = [[WeakTimerProxy alloc] initWithTarget:self];
    self.displayLink = [CADisplayLink displayLinkWithTarget:proxy selector:@selector(linkTimerRun)];
    self.displayLink.preferredFramesPerSecond = 1;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
   
}

- (void)linkTimerRun {
    NSLog(@"timer ++ = %ld", k_abacsd);
    k_abacsd += 1;
}

#pragma mark - Proxy Weak Timer
- (void)proxyWeakTimer {
    WeakTimerProxy *proxy = [[WeakTimerProxy alloc] initWithTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:proxy selector:@selector(timerRun) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)timerRun {
    NSLog(@"timer ++ = %ld", k_abacsd);
    k_abacsd += 1;
}

#pragma mark - dispatch_after Weak Timer

- (void)addTimer {
    __weak typeof(self)weakS = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"timer ++ = %ld", k_abacsd);
        k_abacsd += 1;
        [weakS addTimer];
    });
}

@end
