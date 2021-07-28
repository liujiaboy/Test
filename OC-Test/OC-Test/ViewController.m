//
//  ViewController.m
//  OC-Test
//
//  Created by Alan on 2021/6/21.
//

#import "ViewController.h"
#import "AView.h"
#import "AButton.h"
#import "BButton.h"
#import <YYDispatchQueuePool.h>
#import "Person.h"
#import "Person+A.h"
#import "Person+B.h"
#import "Student.h"
#import "Teacher.h"

@interface ViewController ()

@property (nonatomic, strong) AView *aView;
@property (nonatomic, strong) AButton *btn;
@property (nonatomic, strong) BButton *btn2;
@property (nonatomic, strong) BButton *animateBtn;

@end

@implementation ViewController

- (AButton *)btn {
    if (!_btn) {
        AButton *btn = [AButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"click" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(aBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
//        btn.userInteractionEnabled = NO;
        _btn = btn;
    }
    return _btn;
}

- (BButton *)btn2 {
    if (!_btn2) {
        BButton *btn = [BButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"click" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(bBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = [UIColor orangeColor].CGColor;
        btn.layer.borderWidth = 1;
//        btn.userInteractionEnabled = NO;
        _btn2 = btn;
    }
    return _btn2;
}

- (UIView *)aView {
    if (!_aView) {
        _aView = [AView new];
        _aView.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aViewClick)];
        [_aView addGestureRecognizer:tap];
    }
    return _aView;
}

- (void)aBtnClick {
    NSLog(@"AAA button click...");
}

- (void)bBtnClick {
    NSLog(@"BBB button click...");
}

- (void)aViewClick {
    NSLog(@"view click...");
}

- (void)animateBtnClick {
    NSLog(@"animate button click...");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self strTest];
//    [self mstrTest];
    
//    [self arrayTest];
//    [self marrayTest];
    
//    [self gcdTest];
    
//    [self.view addSubview:self.aView];
//    self.aView.frame = CGRectMake(20, 100, 300, 300);
//
//
//    [self.aView addSubview:self.btn2];
//    self.btn2.frame = CGRectMake(30, 40, 200, 44);
//
//    [self.aView addSubview:self.btn];
//    self.btn.frame = CGRectMake(100, 40, 200, 44);
    
//    self.mArr = [NSMutableArray array];
//    [self.mArr addObject:@"1"];
    
    // animate button
    [self.view addSubview:self.animateBtn];
    self.animateBtn.frame = CGRectMake(20, 100, 100, 40);
    
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.animateBtn.frame = CGRectMake(20, 500, 100, 40);
    } completion:^(BOOL finished) {
        self.animateBtn.frame = CGRectMake(20, 100, 100, 40);
    }];
    
//    [self gcdTest3];
    
    YYDispatchQueuePool *pool = [[YYDispatchQueuePool alloc] initWithName:@"com.alan.queue" queueCount:2 qos:NSQualityOfServiceDefault];
    dispatch_queue_t q1 = [pool queue];
    dispatch_async(q1, ^{
        char *label = dispatch_queue_get_label(q1);
        NSLog(@"name 1 label = %s", label);
        NSLog(@"name 1 = %@", [NSThread currentThread]);
        sleep(5);
    });
    dispatch_queue_t q2 = [pool queue];
    dispatch_async(q2, ^{
        char *label = dispatch_queue_get_label(q2);
        NSLog(@"name 2 label = %s", label);
        NSLog(@"name 2 = %@", [NSThread currentThread]);
        sleep(10);
    });
    dispatch_async([pool queue], ^{
        NSLog(@"name 3 = %@", [NSThread currentThread]);
//        sleep(1);
    });
    dispatch_async([pool queue], ^{
        NSLog(@"name 4 = %@", [NSThread currentThread]);
//        sleep(1);
    });
    
//    [self deadLockFunc];
    
    // inistalized
    [self initializeTest];
    [self arrayTest];
}


- (void)strTest {
    NSString *string = [NSString stringWithString: @"alan.com"];
    NSString *stringCopy = [string copy];
    NSMutableString *stringMCopy = [string mutableCopy];
    NSLog(@"string = %p, stringCopy = %p, stringMCopy = %p", string, stringCopy, stringMCopy);
    [stringMCopy appendString:@"-123"];
    NSLog(@"str = %@", stringMCopy);
    // string = 0x107c86018,
    // stringCopy = 0x107c86018,
    // stringMCopy = 0x600001b30f30
    // immutableObj copy 浅拷贝 拷贝指针，指针地址不变
    // immutableObj mutableCopy 深拷贝 拷贝内容，指针变化
}

- (void)mstrTest {
    NSMutableString *mstring = [NSMutableString stringWithString: @"alan.com"];
    //copy
    NSMutableString *mStringCopy = [mstring copy];
    NSMutableString *stringMCopy = [mstring mutableCopy];
    NSLog(@"string = %p, mStringCopy = %p, stringMCopy = %p", mstring, mStringCopy, stringMCopy);
    // string = 0x600001bf9200,
    // mStringCopy = 0xe514d1c128f09b68,
    // stringMCopy = 0x600001bf9f50
    //change value
//    [mStringCopy appendString:@"mm"]; //crash
    [mstring appendString:@".origion!"];
    [stringMCopy appendString:@"!!"];
    
    // mutableObj copy 深拷贝 拷贝内容，变immutable obj，不可操作
    // mutableObj mutableCopy  深拷贝 拷贝内容
}

- (void)arrayTest {
    NSArray *array = @[[NSMutableString stringWithString: @"alan.com"], @"2"];
    NSArray *arrayCopy = [array copy];
    NSMutableArray *arrayMCopy = [array mutableCopy];
        
    // mutable copy变可变数组
//    [arrayMCopy addObject:@"add name"];
//    NSLog(@"arrayMCopy = %@", arrayMCopy);
    
    NSLog(@"array = %p", array);
    NSLog(@"arrayCopy = %p", arrayCopy);
    NSLog(@"arrayMCopy = %p", arrayMCopy);
        
    for (int i = 0; i < [array count]; i ++) {
        NSLog(@"item = %p, itemCopy = %p, itemMCopy = %p", array[i], arrayCopy[i], arrayMCopy[i]);
    }
/**
 array = 0x600003305ee0
 arrayCopy = 0x600003305ee0
 arrayMCopy = 0x600003db6640
 item = 0x600003db6760, itemCopy = 0x600003db6760, itemMCopy = 0x600003db6760
 item = 0x100bef0e0, itemCopy = 0x100bef0e0, itemMCopy = 0x100bef0e0
 
 array copy         浅拷贝 拷贝指针，指针地址不变    数组内容指针不变
 array mutableCopy  深拷贝 拷贝内容，指针地址变      数组内容指针不变
                    单层深复制
 */
}

- (void)marrayTest {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString: @"alan.com"], @"2", nil];
    NSMutableArray *arrayCopy = [array copy];
    NSMutableArray *arrayMCopy = [array mutableCopy];
    
    // crash
//    [arrayCopy addObject:@"add name"];
//    NSLog(@"arrayCopy = %@", arrayCopy);
    
    NSLog(@"array = %p", array);
    NSLog(@"arrayCopy = %p", arrayCopy);
    NSLog(@"arrayMCopy = %p", arrayMCopy);
    for (int i = 0; i < [array count]; i ++) {
        NSLog(@"item = %p, itemCopy = %p, itemMCopy = %p", array[i], arrayCopy[i], arrayMCopy[i]);
    }
/**
 array = 0x6000009b78a0
 arrayCopy = 0x600000705ee0
 arrayMCopy = 0x6000009b7660
 item = 0x6000009b7870, itemCopy = 0x6000009b7870, itemMCopy = 0x6000009b7870
 item = 0x10f2ea0c0, itemCopy = 0x10f2ea0c0, itemMCopy = 0x10f2ea0c0
 
 marray copy         深拷贝 拷贝内容                数组内容指针不变
 marray mutableCopy  深拷贝 拷贝内容，指针地址变      数组内容指针不变
                     单层深复制
 */
}

- (void)gcdTest {
//    int i = 10;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"i = %d", i);
//    });
//    i = 20;
    
    __block int i = 10;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"i = %d", i);
    });
    i = 20;
}

- (void)gcdTest2 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    
    
    NSLog(@"5");
}

- (void)gcdTest3 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    while (1) {
        
    }
    NSLog(@"5");
}

void func(dispatch_queue_t queue, dispatch_block_t block)
{
    if (dispatch_get_current_queue() == queue) {
        block();
    }else{
        dispatch_sync(queue, block);
    }
}

- (void)deadLockFunc
{
    dispatch_queue_t queueA = dispatch_queue_create("com.yiyaaixuexi.queueA", NULL);
    dispatch_queue_t queueB = dispatch_queue_create("com.yiyaaixuexi.queueB", NULL);
    dispatch_sync(queueA, ^{
        NSLog(@"1");
        dispatch_sync(queueB, ^{
            NSLog(@"2");
            dispatch_block_t block = ^{
                //do something
                NSLog(@"3 block inner...");
            };
            func(queueA, block);
            // 调用queueA发生死锁。queueB在当前线程、正常执行
        });
    });
}

- (void)initializeTest {
    Person *p = [Person new];
    p.name = @"name";
    NSLog(@"name = %@", p.name);
//    [p sayA];
//    Student *st = [Student new];
//    [st sayST];
//
//    Teacher *t = [Teacher new];
//    [t sayTeacher];
}


- (BButton *)animateBtn {
    if (!_animateBtn) {
        BButton *btn = [BButton buttonWithType:UIButtonTypeCustom];
        btn.isAnimate = YES;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"animate button" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(animateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = [UIColor systemPinkColor].CGColor;
        btn.layer.borderWidth = 1;
//        btn.userInteractionEnabled = NO;
        _animateBtn = btn;
    }
    return _animateBtn;
}
@end
