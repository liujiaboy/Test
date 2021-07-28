//
//  ViewController.m
//  Thread-GCD
//
//  Created by Alan on 2021/6/20.
//

#import "ViewController.h"
#import "ReadWriteVC.h"
#import "Person+A.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self NSThreadTest];
    
//    [self sisuoTest];
//    [self dayinshunxu1];
//    [self dayinshunxu2];
//    [self dayinshunxu3];
//    [self dayinshunxu4];
//    [self dayinshunxu5];
    
//    [self performTest1];
    
    // kvo
//    [self addNotifications];
}
- (IBAction)readwriteAction:(id)sender {
    
    ReadWriteVC * vc = [ReadWriteVC new];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - Observer KVO
- (void)addNotifications {
    self.person = [Person new];
    
//    [self.person addObserver:self forKeyPath:@"al_name" options:NSKeyValueObservingOptionNew context:nil];
    
//    self.person.al_name = @"al_name";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change - %@", change);
}

#pragma mark - NSThread
// NSThread
- (void)NSThreadTest {
    NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(thread1) object:nil];
    t.name = @"NSThread-线程";
    [t start];
}

- (void)thread1 {
    NSLog(@"thread 1....");
//    sleep(2);
//    [self performSelector:@selector(thread1timer)];
    [self performSelector:@selector(thread1timer) withObject:nil afterDelay:2];
    // 在子线程中，如果不使用runloop，则timer不会执行。
//    [[NSRunLoop currentRunLoop] run];
}

- (void)thread1timer {
    NSLog(@"thread timer ....");
}

#pragma mark - GCD

- (void)queue1 {
    
}

- (void)sisuoTest {
    NSLog(@"1..");
    // 2在主线程中执行，因为是同步串行队列，所以2一直等待主线程执行完毕。所以发生死锁
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2...");
    });
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"2...");
//    });
    NSLog(@"3...");
}

- (void)dayinshunxu1 {
    // 串行
    dispatch_queue_t seriaQ = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1...");
    dispatch_async(seriaQ, ^{
        NSLog(@"2...");
    });
    NSLog(@"3...");
    dispatch_sync(seriaQ, ^{
        NSLog(@"4...");
    });
    NSLog(@"5...");
    // 1 3 2 4 5
}

// dayinshunxu1和2是同样性质的，不管是不是串行和并发
- (void)dayinshunxu2 {
    // 并发
    dispatch_queue_t concurQ = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1...");
    dispatch_async(concurQ, ^{
        NSLog(@"2...");
    });
    NSLog(@"3...");
    dispatch_sync(concurQ, ^{
        NSLog(@"4...");
    });
    NSLog(@"5...");
    // 1 3 2 4 5
}

// 异步- 异步
- (void)dayinshunxu3 {
    // 这里不管是并发还是串行，结果都是一样的。
    // dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    // 耗时
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    // 1 5 2 4 3
}

// 异步- 同步 - 并发队列
- (void)dayinshunxu4 {
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    // 1 5 2 3 4
}

// 异步-同步 - 串行队列
- (void)dayinshunxu5 {
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    NSLog(@"1");
    // 异步函数
    dispatch_async(queue, ^{
        NSLog(@"2");
        // 同步
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    // 1 5 2
}

#pragma mark - PerformSelector
- (void)performTest1 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        // 1.
//        [self performSelector:@selector(test1) withObject:nil];
        
        // 2. 除了主线程，其他子线程默认不会开启runloop
//        [self performSelector:@selector(test1) withObject:nil afterDelay:0];
//        [[NSRunLoop currentRunLoop] run];
    });
    NSLog(@"3");
}

- (void)test1 {
    NSLog(@"test 1 ...");
}

@end
