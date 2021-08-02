//
//  TimerViewController.m
//  Thread-GCD
//
//  Created by Alan on 2021/8/1.
//

#import "TimerViewController.h"
#import "Person.h"

@interface TimerViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation TimerViewController

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.person = [Person new];
    [self.person addTimer];
//    [self.person proxyWeakTimer];
//    [self.person displayLinkTimer];
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
