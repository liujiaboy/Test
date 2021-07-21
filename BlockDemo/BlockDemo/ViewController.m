//
//  ViewController.m
//  BlockDemo
//
//  Created by Alan on 2021/6/19.
//

#import "ViewController.h"
#import "Person.h"
#import "AViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)buttonClick {
    AViewController *avc = [AViewController new];
    [self presentViewController:avc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 200, 100, 44);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    [self blockTest1];
//    [self blockTest2];
//    [self blockTest3];
//    [self blockTest4];
    
    // global block
    NSLog(@"block = %@", ^{
        
    });
    
    // iOS14之后，即使这种打印方式也不会出现stack block，会执行copy到堆，变成malloc block
    int a = 10;
//    NSLog(@"block = %@", ^{
//        NSLog(@"a = %d", a);
//    });
}

- (void)blockTest1 {
    
    NSInteger num = 3;
    NSInteger(^ablock)(NSInteger n) = ^NSInteger(NSInteger n) {
        return n * num;
    };
    
    num = 1;
    NSLog(@"%ld", ablock(2));
}

- (void)blockTest2 {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    void(^ablock)(void) = ^{
        [array addObject:@"3"];
        NSLog(@"inner = %@", array);
    };
    
    [array addObject:@"4"];
    array = nil;
//    NSLog(@"out1 = %@", array);
    ablock();
    NSLog(@"out2 = %@", array);
    ablock();
}


- (void)blockTest3 {
    Person *p = [Person new];
    p.name = @"A";
    p.age = 12;
    // block截获的是值（p指向的地址）、而不是p的栈指针
    void(^ablock)(void) = ^{
        p.name = @"AAB";
        NSLog(@"in name = %@", p.name);
    };
    p.name = @"B";
//    p = nil;
    NSLog(@"out1 name = %@", p.name);
    ablock();
    NSLog(@"out2 name = %@", p.name);
}

static NSInteger aaa = 1;
- (void)blockTest4 {
    void(^ablock)(NSInteger n) = ^(NSInteger n){
        
        NSLog(@"in a = %ld", aaa * n);
    };
    aaa = 100;
    ablock(2);
}

@end
