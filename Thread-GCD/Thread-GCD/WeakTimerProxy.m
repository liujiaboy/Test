//
//  WeakTimerProxy.m
//  Thread-GCD
//
//  Created by Alan on 2021/8/2.
//

#import "WeakTimerProxy.h"
#import <objc/runtime.h>

@interface WeakTimerProxy ()

@property (nonatomic, weak) id target;

@end

@implementation WeakTimerProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

@end
