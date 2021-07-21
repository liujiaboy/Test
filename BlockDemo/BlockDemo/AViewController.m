//
//  AViewController.m
//  BlockDemo
//
//  Created by Alan on 2021/6/21.
//

#import "AViewController.h"
#import "Person.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 300, 100, 44);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self foo];
}

- (void)buttonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)foo {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(printSomething) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)printSomething {
    static NSInteger count = 0;
    count ++;
    NSLog(@"timer count: %ld",count);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
