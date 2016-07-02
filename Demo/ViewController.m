//
//  ViewController1.m
//  Demo
//
//  Created by 许宗城 on 16/3/14.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightAction {
    
}


@end
