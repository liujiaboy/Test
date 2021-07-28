//
//  WeakAssociateObj.h
//  Thread-GCD
//
//  Created by Alan on 2021/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakAssociateObj : NSObject

@property (nonatomic, strong) id weakObj;

- (void)al_deallocBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
