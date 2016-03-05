//
//  EZAuthentication.m
//  EZFramework_example
//
//  Created by sun on 15/10/10.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZAuthentication.h"
#import "EZCollectionDefault.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static NSMutableDictionary *URLNoNeedLogin = nil;

@implementation EZAuthentication

// 返回YES表示验证成功，返回NO表示验证失败
+ (BOOL)authenticationForUserWithMappingURL:(NSString *)url {
    NSString *mappingInfoPlist = [[NSBundle mainBundle] pathForResource:@"mapping" ofType:@"plist"];
    NSArray *mappingInfo = [NSArray arrayWithContentsOfFile:mappingInfoPlist];
    for (NSDictionary *obj in mappingInfo) {
        if ([obj[@"url"] caseInsensitiveCompare:url] == NSOrderedSame) {
            return [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest || ![obj[@"needLogin"] boolValue];
        }
    }
    return NO;
}

@end
