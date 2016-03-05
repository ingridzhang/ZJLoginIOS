//
//  EZLKDBHelper.m
//  EZFramework_example
//
//  Created by sun on 15/10/10.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZDBHelper.h"

@implementation EZDBHelper

+ (LKDBHelper *)defaultLKDBHelper {
    static LKDBHelper *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[LKDBHelper alloc] init];
    });
    return db;
}

@end
