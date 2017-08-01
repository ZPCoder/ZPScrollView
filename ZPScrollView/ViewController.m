//
//  ViewController.m
//  ZPScrollView
//
//  Created by 朱鹏 on 2017/8/1.
//  Copyright © 2017年 朱鹏. All rights reserved.
//

#import "ViewController.h"
#import "topSelectView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kPinkColor;
    
    topSelectView *selectView = [[topSelectView alloc]initWithFrame:CGRectMake(0, 114, kScreenWidth,100)];
    [self.view addSubview:selectView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
