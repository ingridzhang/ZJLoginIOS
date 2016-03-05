//
//  EZAppConfig.h
//  EZFramework_example
//
//  Created by sun on 15/10/16.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZApp : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString *appName; // like ezjie.ios.toelfzjnew
@property (nonatomic, copy) NSString *deviceToken;

@property (nonatomic, readonly) NSString *uid;
@property (nonatomic, readonly) NSString *loginKey;

@property (nonatomic, copy) NSString *controllerPrefix;
@property (nonatomic, copy) NSString *controllerPostfix;

@property (nonatomic, copy) NSString *openUDID;


@property (nonatomic, strong) BOOL(^authenticationFailure)(void);

- (void)setLoginUserInfo:(NSString *)uid loginKey:(NSString *)loginKey;
- (void)logout;
+ (void)jump:(NSString *)url;

@end
