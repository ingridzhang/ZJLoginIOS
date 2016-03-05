//
//  EZCollectionDefault.m
//  Pods
//
//  Created by sun on 15/10/9.
//
//

#import "EZCollectionDefault.h"
#import <UIKit/UIKit.h>
#import "EZApp.h"
#import "UIDevice+DeviceName.h"

@interface EZCollectionDefault ()

@property (nonatomic, strong) EZApp *app;

@end

@implementation EZCollectionDefault

+ (instancetype)shareInstance {
    static EZCollectionDefault *collectionDefault = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        collectionDefault = [[self alloc] init];
        collectionDefault.app = [EZApp shareInstance];
    });
    return collectionDefault;
}

- (NSString *)deviceId {
    return self.app.openUDID;
}

- (NSString *)uuid {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

- (NSString *)system {
    return @"ios";
}

- (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)appName {
    return self.app.appName;
}

- (NSString *)appVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)versionCode {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (NSString *)nationality {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

- (NSString *)device {
    return [[UIDevice currentDevice] platformString];
}

- (NSString *)deviceToken {
    return self.app.deviceToken;
}

- (NSString *)loginKey {
    return self.app.loginKey;
}

- (NSString *)uid {
    return self.app.uid;
}

- (NSDictionary *)header {
    NSString *parameters = [NSString stringWithFormat: @"{\"device\":\"%@\",\"device_id\":\"%@\",\"cid\":\"\",\"device_token\":\"%@\",\"system\":\"%@\",\"system_version\":\"%@\",\"app_version\":\"%@\",\"version_code\":\"%@\",\"nationality\":\"%@\",\"app_name\":\"%@\",\"login_key\":\"%@\",\"uid\":\"%@\",\"uuid\":\"%@\"}", self.device, self.deviceId, self.deviceToken, self.system, self.systemVersion, self.appVersion, self.versionCode, self.nationality, self.appName, self.loginKey, self.uid, [self uuid]];
    return @{@"parameters":parameters, @"Cookie":[self cookie]};
}

- (NSString *)cookie {
    NSString *cookie = @"";
    if (self.uid.length && self.loginKey.length) {
        cookie = [NSString stringWithFormat:@"uid=%@; login_key=%@; device_id=%@; device=%@; app_version=%@; version_code=%@; system=%@; system_version=%@; app_name=%@; nationality=%@; device_token=%@; uuid=%@", self.uid, self.loginKey, self.deviceId, self.device, self.appVersion, self.versionCode, self.system, self.systemVersion, self.appName, self.nationality, self.deviceToken, [self uuid]];
    } else {
        cookie = [NSString stringWithFormat:@"device_id=%@; device=%@; app_version=%@; version_code=%@; system=%@; system_version=%@; app_name=%@; nationality=%@; device_token=%@; uuid=%@", self.deviceId, self.device, self.appVersion, self.versionCode, self.system, self.systemVersion, self.appName, self.nationality, self.deviceToken, [self uuid]];
    }
    return cookie;
}

@end
