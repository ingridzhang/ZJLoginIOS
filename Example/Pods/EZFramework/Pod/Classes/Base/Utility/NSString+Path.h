//
//  NSString+Path.h
//  沙盒缓存
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

- (NSString *)appendDocumentDir;
- (NSString *)appendCacheDir;
- (NSString *)appendTempDir;

@end
