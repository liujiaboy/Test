//
//  Person+A.m
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import <objc/runtime.h>
#import "Person+A.h"
char *kaaaaaaA;

@implementation Person (A)

//+(void)initialize {
//    NSLog(@"%s", __func__);
//}

+ (void)load {
    NSLog(@"%s = %@", __func__, self);
}

- (void)sayA {
    NSLog(@"%s", __func__);
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &kaaaaaaA, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    NSString *n = objc_getAssociatedObject(self, &kaaaaaaA);
    n = [n stringByAppendingString:@"_A"];
    return n;
}


@end
