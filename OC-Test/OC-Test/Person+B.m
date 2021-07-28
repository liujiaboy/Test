//
//  Person+B.m
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import <objc/runtime.h>
#import "Person+B.h"

char *kaaaaaaB;

@implementation Person (B)

//+(void)initialize {
//    NSLog(@"%s", __func__);
//}

+ (void)load {
    NSLog(@"%s = %@", __func__, self);
}

- (void)sayB {
    NSLog(@"%s", __func__);
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &kaaaaaaB, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    NSString *n = objc_getAssociatedObject(self, &kaaaaaaB);
    n = [n stringByAppendingString:@"_B"];
    return n;
}

@end
