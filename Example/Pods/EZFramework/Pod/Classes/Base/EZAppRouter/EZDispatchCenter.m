//
//  EZDispatchCenter.m
//  EZFramework_example
//
//  Created by sun on 15/10/12.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZDispatchCenter.h"
#import "MJExtension.h"
#import "EZAuthentication.h"

@implementation EZDispatchCenter

+ (instancetype)defaultDispatchCenter {
    static EZDispatchCenter *dispatchCenter = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        dispatchCenter = [[EZDispatchCenter alloc] init];
    });
    return dispatchCenter;
}

- (BOOL)jumpToViewController {
    @try {
        
        if ([EZAuthentication authenticationForUserWithMappingURL:[self urlHost:self.url]] || !self.authenticationFailure || self.authenticationFailure()) {
            id viewController = [[self.jumpController alloc] init];
            [viewController mj_setKeyValues:self.parameters];
            [viewController mj_setKeyValues:self.userInfo];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navController = (UINavigationController *)window.rootViewController;
                [navController pushViewController:viewController animated:YES];
                return YES;
            }
        }
        return NO;
    }
    @catch (NSException *exception) {
        NSLog(@"exception=%@", exception);
        return NO;
    }
    @finally {
        return NO;
    }
}

- (NSString *)urlHost:(NSString *)urlHost {
    NSString *url = self.url;
    NSUInteger location = [self.url rangeOfString:@"?"].location;
    if (location != NSNotFound) {
        url = [self.url substringToIndex:location];
    }
    return url;
}

@end
