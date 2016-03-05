//
//  EZAppConfig.m
//  EZFramework_example
//
//  Created by sun on 15/10/16.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZApp.h"
#import "EZAppRouter.h"
#import "EZAuthentication.h"
#import "EZCollectionDefault.h"

@interface EZApp ()

@property (nonatomic, readwrite) NSString *uid;
@property (nonatomic, readwrite) NSString *loginKey;

@end

@implementation EZApp

+ (instancetype)shareInstance {
    static EZApp *appConfig = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        appConfig = [[EZApp alloc] init];
    });
    return appConfig;
}

- (NSString *)appName {
    return _appName ?: @"";
}

- (NSString *)deviceToken {
    return _deviceToken ?: @"";
}

- (NSString *)uid {
    return _uid ? : @"";
}

- (NSString *)loginKey {
    return _loginKey ?: @"";
}

- (NSString *)controllerPrefix {
    return _controllerPrefix ?: @"";
}

- (NSString *)controllerPostfix {
    return _controllerPostfix ?: @"";
}

- (NSString *)openUDID {
    return _openUDID ?: @"";
}

- (void)setLoginUserInfo:(NSString *)uid loginKey:(NSString *)loginKey {
    if ([uid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length &&
        [loginKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length) {
        self.uid = uid;
        self.loginKey = loginKey;
        [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = YES;
    }
}

- (void)logout {
    self.uid = @"";
    self.loginKey = @"";
    [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = NO;
}

+ (void)jump:(NSString *)url {
    [[EZAppRouter standardRouter] jump:url];
}

@end
