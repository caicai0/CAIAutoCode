//
//  ViewController.m
//  CAIAutoCode
//
//  Created by liyufeng on 14/12/22.
//  Copyright (c) 2014年 liyufeng. All rights reserved.
//

#import "ViewController.h"
#import "AClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AClass *a = [[AClass alloc]init];
    a.string = @"123";
    a.integer = 12323123;
    a.numFloat = 123.4;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:a];
    AClass * b = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@,%ld,%f",b.string,b.integer,b.numFloat);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
