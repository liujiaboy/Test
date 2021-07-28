//
//  WeakAssociateObj.m
//  Thread-GCD
//
//  Created by Alan on 2021/7/28.
//

#import "WeakAssociateObj.h"

static char *kWeakAssociate_key;

@interface WeakAssociateObj ()

@property (nonatomic, copy)void(^deallocBlock)(void);

@end

@implementation WeakAssociateObj

- (void)dealloc
{
    if (self.deallocBlock) {
        self.deallocBlock();
    }
//    self.weakObj = nil;
}

- (void)al_deallocBlock:(void(^)(void))block {
    self.deallocBlock = block;
}

@end
