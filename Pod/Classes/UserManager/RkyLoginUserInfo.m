
#import "RkyLoginUserInfo.h"
#import "LoginHeader.h"

@implementation RkyLoginUserInfo

+ (instancetype)sharedInstance {
    static RkyLoginUserInfo *userManager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        userManager = [[RkyLoginUserInfo alloc] init];
    });
    return userManager;
}

@end
