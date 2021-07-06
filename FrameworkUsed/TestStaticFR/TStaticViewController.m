//
//  TStaticViewController.m
//  TestStaticFR
//
//  Created by Alan on 2021/7/4.
//

#import "TStaticViewController.h"
#import "TStaticObject.h"

@interface TStaticViewController ()

@property (nonatomic, strong) TStaticObject *obj;

@end

@implementation TStaticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"Test_VC -- FR";
    
    TStaticObject *obj = [TStaticObject new];
    obj.name = @"TEST Object Name";
    self.obj = obj;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"test button" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 44);
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)buttonClick {
    NSLog(@"test Object name = %@", self.obj.name);
    if (self.buttonClickBlock) {
        self.buttonClickBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
