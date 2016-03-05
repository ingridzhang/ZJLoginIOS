//
//  RkyAppDelegate.m
//  EasyLoginIOS
//
//  Created by zhangjing on 01/21/2016.
//  Copyright (c) 2016 zhangjing. All rights reserved.
//

#import "RkyAppDelegate.h"
#import "WXApi.h"
#import "RkyLoginMacro.h"
#import "RkyWeixinHandler.h"
#import "EZApp.h"

@implementation RkyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WXApi registerApp:kWeixinAppKey];
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    
    EZApp *app = [EZApp shareInstance];
    app.appName = @"ezjie.ios.toelfzjnew";
    app.controllerPrefix = @"Rky";
    app.openUDID = deviceID;
    app.controllerPostfix = @"ViewController";
//    [app setLoginUserInfo:[@([RkyUserManager sharedInstance].userInfo.userID) stringValue] loginKey:[RkyUserManager sharedInstance].userInfo.loginKey];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [self openURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self openURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self openURL:url];
}

- (BOOL)openURL:(NSURL *)url {
    if ([[url scheme] isEqualToString:kWeixinAppKey]) {
        return [WXApi handleOpenURL:url delegate:[RkyWeixinHandler sharedInstance]];
    }
    return NO;
}

@end
