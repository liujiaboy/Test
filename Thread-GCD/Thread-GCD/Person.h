//
//  Person.h
//  Thread-GCD
//
//  Created by Alan on 2021/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (void)addTimer;

- (void)proxyWeakTimer;

- (void)displayLinkTimer;

@end

NS_ASSUME_NONNULL_END
