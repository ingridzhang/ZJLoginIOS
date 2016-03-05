//
//  NSDictionary+Access.h
//  EasyJie
//  可通过此类直接得到相应的基础类型，不需要通过NSNumber进行转换
//  Created by ricky on 14-8-28.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Access)

- (BOOL)boolValueForKey:(NSString *)key;
- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (int)intValueForKey:(NSString *)key;
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (float)floatValueForKey:(NSString *)key;
- (float)floatValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (time_t)timeValueForKey:(NSString *)key;
- (time_t)timeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;

- (long long)longLongValueForKey:(NSString *)key;
- (long long)longLongValueForKey:(NSString *)key defaultValue:(long long)defaultValue;

- (long long)unsignedLongLongValueForKey:(NSString *)key;
- (long long)unsignedLongLongValueForKey:(NSString *)key defaultValue:(unsigned long long)defaultValue;

- (double)doubleValueForKey:(NSString *)key;
- (double)doubleValueForKey:(NSString *)key defaultValue:(double)defaultValue;

- (NSInteger)integerValueForKey:(NSString*)key;
- (NSInteger)integerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

- (NSInteger)unsignedIntegerValueForKey:(NSString*)key;
- (NSInteger)unsignedIntegerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

- (NSString *)stringValueForKey:(NSString *)key;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

- (NSDictionary *)dictionaryValueForKey:(NSString *)key;
- (NSArray *)arrayValueForKey:(NSString *)key;

@end
