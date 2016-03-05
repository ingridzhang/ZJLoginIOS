//
//  EZRouter.m
//  EZFramework_example
//
//  Created by sun on 15/10/12.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZAppRouter.h"
#import "MGJRouter.h"
#import "EZDispatchCenter.h"
#import "NSString+SplitOnCapital.h"
#import "EZApp.h"

@implementation EZAppRouter

+ (instancetype)standardRouter {
    static EZAppRouter *router = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        router = [[EZAppRouter alloc] init];
        [MGJRouter registerURLPattern:@"app:///:module/:action" toHandler:^(NSDictionary *routerParameters) {
            EZDispatchCenter *dispatchCenter = [EZDispatchCenter defaultDispatchCenter];
            
            if ([routerParameters[@"action"] isKindOfClass:[NSString class]]) {
                
                NSString *viewConrollerName = [[routerParameters[@"module"] toCamelCase] stringByAppendingString:[routerParameters[@"action"] toCamelCase]];
                EZApp *app = [EZApp shareInstance];
                dispatchCenter.jumpController = NSClassFromString([[app.controllerPrefix stringByAppendingString:viewConrollerName] stringByAppendingString:app.controllerPostfix]);
                dispatchCenter.module = routerParameters[@"module"];
                dispatchCenter.parameters = routerParameters;
                dispatchCenter.userInfo = routerParameters[MGJRouterParameterUserInfo];
                dispatchCenter.url = routerParameters[MGJRouterParameterURL];
                dispatchCenter.authenticationFailure = [EZApp shareInstance].authenticationFailure;
                [dispatchCenter jumpToViewController];
            }
        }];
    });
    return router;
}

- (void)jump:(NSString *)url {
    [self jump:url userInfo:nil];
}

- (void)jump:(NSString *)url userInfo:(NSDictionary *)userInfo {
    [MGJRouter openURL:url withUserInfo:userInfo completion:nil];
}

@end
