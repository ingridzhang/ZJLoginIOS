//
//  UIFont+RkySkin.h
//  EasyJie
//
//  Created by ricky on 14-8-23.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginHeader.h"

@interface UIFont (RkySkin)

+ (instancetype) fontForModule:(NSString *)module target:(NSString *)target;
+ (instancetype) fontForModule:(NSString *)module target:(NSString *)target skinStyle:(RkySkinStyle) skinStyle;
@end
