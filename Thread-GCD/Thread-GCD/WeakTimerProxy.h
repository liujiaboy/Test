//
//  WeakTimerProxy.h
//  Thread-GCD
//
//  Created by Alan on 2021/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakTimerProxy : NSProxy

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
