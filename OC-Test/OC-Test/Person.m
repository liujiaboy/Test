//
//  Person.m
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import "Person.h"

@implementation Person

/**
 这里需要注意：
 1、分类的initialize会覆盖主类的，多个分类时与资源加载顺序有关，执行最后加载的的分类
 2、当子类也实现了initialize，则会先执行父类的initialize，然后再执行子类。
 3、如果多个子类，只要父类调用过一次initialize，其他子类再调用initialize方法时，不会执行父类的。
 4、如果子类都没有实现initialize，则子类的第一次调用都会调用父类的initialize
 */
//+(void)initialize {
//    NSLog(@"%s = %@", __func__, self);
//}

+ (void)load {
    NSLog(@"%s = %@", __func__, self);
}

- (void)say {
    NSLog(@"%s", __func__);
}

@end
