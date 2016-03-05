//
//  RkyViewController.m
//  EasyLoginIOS
//
//  Created by zhangjing on 01/21/2016.
//  Copyright (c) 2016 zhangjing. All rights reserved.
//

#import "RkyViewController.h"
#import "RkyLoginViewController.h"
#import "MobClick.h"

@interface RkyViewController ()

@end

@implementation RkyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"login" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button sizeToFit];
   
    button.centerX = self.view.width / 2;
    button.centerY = self.view.height / 2;
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)login {
    
    Class cls = [MobClick class];
    RkyLoginViewController *vc = [[RkyLoginViewController alloc] init];
    vc.MobClick = cls;
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navigationVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
