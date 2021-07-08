//
//  ViewController.m
//  Framework-1
//
//  Created by Alan on 2021/7/4.
//

#import "ViewController.h"
//#import "TestStaticFR.framework/Headers/TestStaticFR.h"
#import "TestStaticFR.framework/Headers/TestStaticFR.h"

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
        block();\
    } else {\
        dispatch_async(queue, block);\
    }
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Class cl = NSClassFromString(@"DYObject");
    id obj = [[cl alloc] init];
    [obj performSelector:@selector(sayNB)];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"View Controller" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 300, 300, 44);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)clickAction {
    TStaticViewController *vc = [TStaticViewController new];
    vc.buttonClickBlock = ^{
        NSLog(@"back ...");
    };
    [self presentViewController:vc animated:YES completion:nil];
    
//    UIViewController *a = [self returnValue];
//    NSLog(@"str = %@", a);
}

- (UIViewController *)returnValue {
    __block UIViewController *be = nil;
    dispatch_queue_async_safe(dispatch_get_main_queue(), ^{
        sleep(2);
        
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor redColor];
        [self presentViewController:vc animated:YES completion:nil];
        
        be = vc;
    });
    return be;
}

- (NSString *)abc {
    return @"123";
}

@end
