//
//  Student.m
//  OC-Test
//
//  Created by Alan on 2021/7/25.
//

#import "Student.h"

@implementation Student

//+(void)initialize {
//    NSLog(@"%s = %@", __func__, self);
//}

+ (void)load {
    NSLog(@"%s = %@", __func__, self);
}

- (void)sayST {
    NSLog(@"%s", __func__);
}

@end
