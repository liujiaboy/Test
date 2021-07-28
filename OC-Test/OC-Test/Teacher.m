//
//  Teacher.m
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import "Teacher.h"

@implementation Teacher

//+(void)initialize {
//    NSLog(@"%s = %@", __func__, self);
//}

+ (void)load {
    NSLog(@"%s = %@", __func__, self);
}

- (void)sayTeacher {
    NSLog(@"%s", __func__);
}

@end
