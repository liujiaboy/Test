//
//  ReadWriteVC.m
//  Thread-GCD
//
//  Created by Alan on 2021/7/27.
//

#import "ReadWriteVC.h"

@interface ReadWriteVC () {
    dispatch_queue_t _queue1;
}

@property (nonatomic, strong) NSMutableDictionary *dict;

//@property (nonatomic, strong) ;

@end

@implementation ReadWriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"read write";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dict = [NSMutableDictionary dictionary];
    [self.dict setValue:@"1" forKey:@"1"];
    [self.dict setValue:@"2" forKey:@"2"];
    
    _queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    
    [self safe_ValueForKey:@"1" success:^(NSString *value) {
        NSLog(@"key = 1, value = %@", value);
    }];
    [self safe_ValueForKey:@"2" success:^(NSString *value) {
        NSLog(@"key = 2, value = %@", value);
    }];
    [self safe_SetValue:@"3" forKey:@"3"];
//    [self safe_ValueForKey:@"3" success:^(NSString *value) {
//        NSLog(@"key = 3, value = %@", value);
//    }];
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

- (void)safe_SetValue:(NSString *)value forKey:(NSString *)key {
    
    dispatch_barrier_async(_queue1, ^{
        NSLog(@"start write ...");
        [self.dict setObject:value forKey:key];
        sleep(5);
        NSLog(@"end write ...");
    });
    
    NSLog(@"set method 2...");
}

@end
