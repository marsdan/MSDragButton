//
//  ViewController.m
//  MSDragBtn
//
//  Created by peng zhao on 2019/11/26.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "ViewController.h"
#import "MSDragButton.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(10, 64, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height - 64 - 80)];
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
    
    MSDragButton *btn = [MSDragButton buttonWithType:UIButtonTypeCustom];
    btn.cagingArea = CGRectMake(0, 0, contentView.bounds.size.width, contentView.bounds.size.height);;
    btn.remainStyle = MSDragButtonRemainStyleAutomaticMarginRight;
    
    
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(CGRectGetMidX(contentView.frame), CGRectGetMidY(contentView.frame), 80, 80);
    [contentView addSubview:btn];
    

   }


@end
