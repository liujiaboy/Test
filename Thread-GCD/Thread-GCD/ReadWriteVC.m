//
//  ReadWriteVC.m
//  Thread-GCD
//
//  Created by Alan on 2021/7/27.
//

#import "ReadWriteVC.h"

#import "WeakAssociateObj.h"
#import "Person+A.h"

@interface ReadWriteVC () {
//    dispatch_queue_t _queue1;
}

@property (nonatomic, strong) NSMutableDictionary *dict;

@property (nonatomic, strong) dispatch_queue_t queue1;

@property (nonatomic, strong) Person *person;

@end

@implementation ReadWriteVC

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"read write";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dict = [NSMutableDictionary dictionary];
    _queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    [self readWriteTest2];
    
//    weak
//    [self weakAssociate];
//    NSLog(@"array = %@", self.person.weakArray);
    
    // NSNotification
//    [self addNotify];
}

#pragma mark - Weak Associate
- (void)weakAssociate {
    self.person = [Person new];
    self.person.weakArray = @[@1, @2];
}

#pragma mark - NSNotification
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify_a) name:@"kAAAA_notification" object:@1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify_b) name:@"kAAAA_notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify_c:) name:nil object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kAAAA_notification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:nil object:nil];
}

- (void)notify_a {
    NSLog(@"%s", __func__);
}

- (void)notify_b {
    NSLog(@"%s", __func__);
}

- (void)notify_c:(NSNotification *)nofity {
    NSLog(@"%s, name = %@", __func__, nofity.name);
    
}

#pragma mark - Read Write
- (void)readWriteTest1 {
    [self.dict setValue:@"1" forKey:@"1"];
    [self.dict setValue:@"2" forKey:@"2"];
    
    [self safe_ValueForKey:@"1" success:^(NSString *value) {
        NSLog(@"key = 1, value = %@", value);
    }];
    [self safe_ValueForKey:@"2" success:^(NSString *value) {
        NSLog(@"key = 2, value = %@", value);
    }];
    [self safe_SetValue:@"3" forKey:@"3"];
    [self safe_ValueForKey:@"3" success:^(NSString *value) {
        NSLog(@"key = 3, value = %@", value);
    }];
}

- (void)readWriteTest2 {
    
    [self.dict setValue:@"1" forKey:@"1"];
    [self.dict setValue:@"2" forKey:@"2"];
//    [self safe_SetValue:@"1" forKey:@"1"];
//    [self safe_SetValue:@"2" forKey:@"2"];
    
    [self safe_GetValueForKey:@"1"];
    [self safe_GetValueForKey:@"2"];
//    [self safe_SetValue:@"3" forKey:@"3"];
//    [self safe_GetValueForKey:@"3"];
    
}

- (void)safe_ValueForKey:(NSString *)key success:(void(^)(NSString *value))success {
    NSString *key1 = [key copy];
    __block NSString *value = nil;
    
    dispatch_async(_queue1, ^{
        NSLog(@"start read key = %@ ...", key);
        value = [self.dict objectForKey:key1];
        sleep(4);
        if (success) {
            success(value);
        }
    });
//    NSLog(@"end read key = %@ value = %@...", key, value);
//    return value;
}

- (NSString *)safe_GetValueForKey:(NSString *)key {
    __block NSString *value = nil;
    NSLog(@"strart read key=%@...", key);
    dispatch_sync(_queue1, ^{
        value = [self.dict objectForKey:key];
        sleep(3);
        NSLog(@"end read key=%@, value=%@...", key, value);
    });
    return value;
}

- (void)safe_SetValue:(NSString *)value forKey:(NSString *)key {
    
    dispatch_barrier_async(_queue1, ^{
        NSLog(@"start write ...");
        [self.dict setObject:value forKey:key];
        sleep(5);
        NSLog(@"end write ...");
    });
    
//    NSLog(@"set method 2...");
}

@end
