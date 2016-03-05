//
//  UIImage+RkySkin.h
//  EasyJie
//
//  Created by ricky on 14-8-23.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginHeader.h"

@interface UIImage (RkySkin)

+ (instancetype)imageForKey: (NSString *)key;
+ (instancetype)imageForKey: (NSString *)key skinStyle:(RkySkinStyle) skinStyle;
+ (instancetype)imageForKey: (NSString *)key skinStyle:(RkySkinStyle) skinStyle cache:(BOOL)cache;

@end
