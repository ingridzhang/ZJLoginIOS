//
//  NSDictionary+Access.m
//  EasyJie
//
//  Created by ricky on 14-8-28.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import "NSDictionary+Access.h"

@implementation NSDictionary (Access)

#pragma mark -- bool

- (BOOL)boolValueForKey:(NSString *)key
{
    return [self boolValueForKey:key defaultValue:NO];
}

- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj boolValue];
    
}

#pragma mark -- int
- (int)intValueForKey:(NSString *)key
{
    return [self intValueForKey:key defaultValue:0];
}

- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
    
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj intValue];
    
}


#pragma mark -- float
- (float)floatValueForKey:(NSString *)key
{
    return [self floatValueForKey:key defaultValue:0];
}

- (float)floatValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
    
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj floatValue];
    
}


#pragma mark -- time
- (time_t)timeValueForKey:(NSString *)key
{
    return [self timeValueForKey:key defaultValue:0];
}

- (time_t)timeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue
{
	id timeObject = [self objectForKey:key];
    if ([timeObject isKindOfClass:[NSNumber class]])
    {
        NSNumber *n = (NSNumber *)timeObject;
        CFNumberType numberType = CFNumberGetType((CFNumberRef)n);
        NSTimeInterval t;
        if (numberType == kCFNumberLongLongType) {
            t = [n longLongValue] / 1000;
        }
        else {
            t = [n longValue];
        }
        return t;
    }
    else if ([timeObject isKindOfClass:[NSString class]])
    {
        NSString *stringTime   = timeObject;
        if (stringTime.length == 13)
        {
            long long llt = [stringTime longLongValue];
            NSTimeInterval t = llt / 1000;
            return t;
        }
        else if (stringTime.length == 10)
        {
            long long lt = [stringTime longLongValue];
            NSTimeInterval t = lt;
            return t;
        }
        else
        {
            if (!stringTime || (id)stringTime == [NSNull null])
            {
                stringTime = @"";
            }
            struct tm created;
            time_t now;
            time(&now);
            
            if (stringTime)
            {
                if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
                {
                    strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
                }
                return mktime(&created);
            }
        }
    }
	return defaultValue;
}

#pragma mark -- ll
- (long long)longLongValueForKey:(NSString *)key
{
    
    return [self longLongValueForKey:key defaultValue:0];
    
}

- (long long)longLongValueForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj longLongValue] ;
    
}

#pragma mark -- ull
- (long long)unsignedLongLongValueForKey:(NSString *)key
{
    
    return [self unsignedLongLongValueForKey:key defaultValue:0];
    
}
- (long long)unsignedLongLongValueForKey:(NSString *)key defaultValue:(unsigned long long)defaultValue
{
    
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj unsignedLongLongValue] ;
    
}

#pragma mark -- double
- (double)doubleValueForKey:(NSString *)key
{
    return [self doubleValueForKey:key defaultValue:0];
}

- (double)doubleValueForKey:(NSString *)key defaultValue:(double)defaultValue
{
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj doubleValue] ;
    
}

#pragma mark -- NSInteger
- (NSInteger)integerValueForKey:(NSString*)key
{
    
    return [self integerValueForKey:key defaultValue:0];
    
}

- (NSInteger)integerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    
    return [obj integerValue] ;
    
}

#pragma mark -- NSUInteger
- (NSInteger)unsignedIntegerValueForKey:(NSString*)key
{
    return [self unsignedIntegerValueForKey:key defaultValue:0];
}

- (NSInteger)unsignedIntegerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id obj = [self objectForKey:key];
    
    if (obj == [NSNull null]) {
        return defaultValue;
    }
    return [obj unsignedIntegerValue];
}

#pragma mark -- string
- (NSString *)stringValueForKey:(NSString *)key
{
    
    return [self stringValueForKey:key defaultValue:nil];
    
}

- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    
    if ([self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null])
    {
        if ([self objectForKey:key] == [NSNull null]) {
        }
        return defaultValue;
    }
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNumber class]])
    {
        return [result stringValue];
    }
    return result;
    
}


#pragma mark -- dict
- (NSDictionary *)dictionaryValueForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    
    if (obj && [obj isKindOfClass:[NSDictionary class]])
    {
        return (NSDictionary *)obj;
    }else if(obj){
    }
    return nil;
    
}


#pragma mark -- array
- (NSArray *)arrayValueForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    
    if (obj && [obj isKindOfClass:[NSArray class]])
    {
        return (NSArray *)obj;
    }else if(obj){

    }
    return nil;
    
}
@end
