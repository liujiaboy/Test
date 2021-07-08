//
//  DYObject.m
//  dynamic-fr
//
//  Created by Alan on 2021/7/8.
//

#import "DYObject.h"

@implementation DYObject

- (void)sayNB {
    NSLog(@"%@ is NB", self.name);
    NSLog(@"到底有没有？？？");
    [self hello];
}

- (void)hello {
    NSLog(@"hello....");
}

@end
