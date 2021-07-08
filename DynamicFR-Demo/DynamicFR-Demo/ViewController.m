//
//  ViewController.m
//  DynamicFR-Demo
//
//  Created by Alan on 2021/7/8.
//

#import "ViewController.h"

#import "DYObject.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DYObject *obj = [DYObject new];
    obj.name = @"DY";
    [obj sayNB];
    // Do any additional setup after loading the view.
}


@end
