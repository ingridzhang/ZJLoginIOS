//
//  RkyLoginViewController.h
//  EasyJie
//
//  Created by ricky on 14-8-26.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//


#import "RkyLoginView.h"

@interface RkyLoginViewController : UIViewController
/*
 非必须使用
 当用户选择 登录与否   判断页面是否跳转  YES表示需要跳转  NO表示不需要跳转
 */
@property(nonatomic,strong)void(^cancelLogin)();
@property (nonatomic,strong) Class MobClick;
@end