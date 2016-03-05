
#import "RkyMailHandler.h"
#import "RkyLoginService.h"
#import "LoginHeader.h"

@interface RkyMailHandler ()

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

@end

@implementation RkyMailHandler

- (void) dealloc
{

}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static RkyMailHandler   *_sharedInstance;
    
    dispatch_once(&once, ^{
        _sharedInstance = [[RkyMailHandler alloc] init];
        
    });
    return _sharedInstance;
}

- (void)loginWithEmail:(NSString *)email mobile:(NSString *)mobile password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self.sessionDataTask cancel];
    self.sessionDataTask = [RkyLoginService login:@{@"mobile":mobile, @"email":email, @"password":password} success:^(RkyUser *user) {
        [RkyLoginUserInfo sharedInstance].userInfo = user;
        [[EZApp shareInstance] setLoginUserInfo:[@(user.userID) stringValue] loginKey:user.loginKey];
        [RkyLoginUserInfo sharedInstance].loginType = RkyLoginTypeMail;
        success(user);
    } failure:^(NSError *error){
        failure(error);
    }];
}

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(id model))success failure:(void(^)(NSError *error))failure {
    [self loginWithEmail:@"" mobile:mobile password:password success:^(id model) {
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void(^)(id model))success failure:(void(^)(NSError *error))failure {
    [self loginWithEmail:email mobile:@"" password:password success:^(id model) {
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)loginOutWithSuccess:(void(^)(id model))success failure:(void (^)(void))failure
{
    [RkyLoginService logoutSuccess:^(id model) {
        if (success) {
            success(model);
        }
    } failure:^{
        if (failure) {
            failure();
        }
    }];
}

@end
