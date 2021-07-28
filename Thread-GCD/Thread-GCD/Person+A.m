//
//  Person+A.m
//  Thread-GCD
//
//  Created by Alan on 2021/7/28.
//

#import "Person+A.h"
#import <objc/runtime.h>
#import "WeakAssociateObj.h"

static char *kPerson_A;
static char *kPerson_weak;

@implementation Person (A)

#pragma mark - 测试KVO
- (void)setAl_name:(NSString *)al_name {
    objc_setAssociatedObject(self, &kPerson_A, al_name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)al_name {
    return objc_getAssociatedObject(self, &kPerson_A);
}

#pragma mark - 测试 weak Associate
- (void)setWeakArray:(NSArray *)weakArray {
    WeakAssociateObj *weakObj = [WeakAssociateObj new];
    weakObj.weakObj = weakArray;
    [weakObj al_deallocBlock:^{
//        weakObj.weakObj = nil;
    }];
    objc_setAssociatedObject(self, &kPerson_weak, weakObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)weakArray {
    WeakAssociateObj *obj = objc_getAssociatedObject(self, &kPerson_weak);
    return obj.weakObj;
}


@end
