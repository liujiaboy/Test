//
//  ViewController.m
//  FrameworkUsed
//
//  Created by Alan on 2021/7/4.
//

#import "ViewController.h"
#import "TStaticViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}

@end
