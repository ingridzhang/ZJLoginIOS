//
//  NSString+Path.m
//  沙盒缓存
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendDocumentDir{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendCacheDir{
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];

}
- (NSString *)appendTempDir{
    
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
