//
//  RkyLoginService.m
//  EasyJieApp
//
//  Created by sun on 15/10/22.
//  Copyright © 2015年 easyjie. All rights reserved.
//

#import "RkyLoginService.h"
#import "EZRequestAndDataMapping.h"
#import "MJExtension.h"
#import "RkyUser.h"
#import "RkyForgetPasswordModel.h"
#import "LoginHeader.h"

@implementation RkyLoginService

+ (void)sendSMSCodeFromForgetPassword:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/sendsmscode"] modelClass:nil parameters:parameters success:^(NSDictionary *response) {
        success(response[@"msg"]);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)sendSMSCode:(NSDictionary *)parameters success:(void(^)(id model))success
            failure:(void(^)(void))failure{
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/sendsmscode"] modelClass:nil parameters:parameters success:^(NSDictionary *response) {
        RkyForgetPasswordModel *forgetPasswordModel = [[RkyForgetPasswordModel alloc] init];
        [forgetPasswordModel mj_setKeyValues:response];
        success(forgetPasswordModel);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)sendEmail:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"user/sendemailcode"] modelClass:nil parameters:parameters success:^(id model) {
        success(model);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)checkSMSCode:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/checksmscode"] modelClass:nil parameters:parameters success:^(NSDictionary *response) {
        RkyForgetPasswordModel *model = [[RkyForgetPasswordModel alloc] init];
        [model mj_setKeyValues:response];
        success(model);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)checkEmail:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure{
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/checkemailcode"] modelClass:nil parameters:parameters success:^(id model) {
        success(model);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)resetPassword:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/resetpassword"] modelClass:nil parameters:parameters success:^(NSDictionary *response) {
        RkyForgetPasswordModel *forgetPasswordModel = [[RkyForgetPasswordModel alloc] init];
        [forgetPasswordModel mj_setKeyValues:response];
        success(forgetPasswordModel);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)registerUser:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/register"] modelClass:nil parameters:parameters success:^(NSDictionary *userDic) {
        [RkyUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"loginKey":@"login_key",
                     @"nickName":@"user.nick_name",
                     @"photo":@"user.head_url",
                     @"userID":@"user.uid",
                     @"loginToken":@"login_token",
                     @"email":@"user.email"
                     };
        }];
        RkyUser *user = [RkyUser mj_objectWithKeyValues:userDic[@"data"]];
        if (user && !user.email.length) {
            user.email = userDic[@"data"][@"user"][@"mobile"];
        }
        success(user);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (NSURLSessionDataTask *)login:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(NSError *error))failure {
    return [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/login"] modelClass:nil parameters:parameters success:^(NSDictionary *userDic) {
        
        [RkyUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                        @"loginKey":@"login_key",
                        @"nickName":@"user.nick_name",
                        @"photo":@"user.head_url",
                        @"userID":@"user.uid",
                        @"loginToken":@"login_token",
                        @"email":@"user.email"
                        };
        }];
        
        RkyUser *user = [RkyUser mj_objectWithKeyValues:userDic[@"data"]];
        if (user && !user.email.length) {
            user.email = userDic[@"data"][@"user"][@"mobile"];
        }
        if (user.userID && user.loginKey.length) {
            success(user);
        } else {
            NSError *error = [NSError errorWithDomain:userDic[@"msg"] code:1001 userInfo:nil];
            failure(error);
        }
    } failure:^(NSError *error, long statusCode) {
        NSError *netError = [NSError errorWithDomain:@"网络异常，请稍后重试" code:1000 userInfo:nil];
        failure(netError);
    }];
}

+ (void)getAgreementSuccess:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping GET:[kBaseURL stringByAppendingString:@"/user/agreement"] modelClass:nil parameters:nil success:^(NSDictionary *response) {
        ((NSNull *)response[@"data"] == [NSNull null]) ? failure() : success(response[@"data"][@"content"]);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (void)logoutSuccess:(void(^)(id model))success failure:(void(^)(void))failure {
    [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/logout"] modelClass:nil parameters:nil success:^(NSDictionary *response) {
        if ([response[@"status_code"] integerValue] == 200) {
            success(response);
        } else {
            failure();
        }
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (NSURLSessionDataTask *)weChatLogin:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(NSError *error))failure {
    return [EZRequestAndDataMapping POST:[kBaseURL stringByAppendingString:@"/user/wxlogin"] modelClass:nil parameters:parameters success:^(NSDictionary *userDic) {
        [RkyUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"loginKey":@"login_key",
                     @"nickName":@"user.nick_name",
                     @"photo":@"user.head_url",
                     @"userID":@"user.uid",
                     @"loginToken":@"login_token",
                     @"email":@"user.email"
                     };
        }];
        RkyUser *user = [RkyUser mj_objectWithKeyValues:userDic[@"data"]];
        if (user && !user.email.length) {
            user.email = userDic[@"data"][@"user"][@"mobile"];
        }
        if (user.userID && user.loginKey.length) {
            success(user);
        } else {
            NSError *error = [NSError errorWithDomain:userDic[@"msg"] code:1001 userInfo:nil];
            failure(error);
        }
    } failure:^(NSError *error, long statusCode) {
        NSError *netError = [NSError errorWithDomain:@"网络异常，请稍后重试" code:1000 userInfo:nil];
        failure(netError);
    }];
}

+ (NSURLSessionDataTask *)getAccessToken:(NSString *)code success:(void(^)(id model))success failure:(void(^)(void))failure {
    return [EZRequestAndDataMapping GET:@"https://api.weixin.qq.com/sns/oauth2/access_token" modelClass:nil parameters:@{@"appid":kWeixinAppKey, @"secret":kWeixinAppSecret, @"code":code, @"grant_type":@"authorization_code"} success:^(NSDictionary *response) {
        
        [RkyAuthInfo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"accessToken":@"access_token",
                     @"expireSec":@"expires_in",
                     @"refreshToken":@"refresh_token",
                     @"openID":@"openid",
                     @"scope":@"scope"
                     };
        }];
        RkyAuthInfo *authInfo = [RkyAuthInfo mj_objectWithKeyValues:response];
        success(authInfo);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (NSURLSessionDataTask *)refreshAccessToken:(NSString *)refreshToken success:(void(^)(id model))success failure:(void(^)(void))failure {
    return [EZRequestAndDataMapping GET:@"https://api.weixin.qq.com/sns/oauth2/refresh_token" modelClass:nil parameters:@{@"appid":kWeixinAppKey, @"grant_type":@"refresh_token", @"refresh_token":refreshToken} success:^(NSDictionary *response) {
        [RkyAuthInfo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"accessToken":@"access_token",
                     @"expireSec":@"expires_in",
                     @"refreshToken":@"refresh_token",
                     @"openID":@"openid",
                     @"scope":@"scope"
                     };
        }];
        RkyAuthInfo *authInfo = [RkyAuthInfo mj_objectWithKeyValues:response];
        success(authInfo);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

+ (NSURLSessionDataTask *)getWeChatUserInfo:(NSString *)accessToken openId:(NSString *)openId success:(void(^)(id model))success failure:(void(^)(void))failure {
    return [EZRequestAndDataMapping GET:@"https://api.weixin.qq.com/sns/userinfo" modelClass:nil parameters:@{@"access_token":accessToken, @"openid":openId} success:^(NSDictionary *response) {
        [RkyUser mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"openID":@"openid",
                     @"nickName":@"nickname",
                     };
        }];
        RkyUser *user = [RkyUser mj_objectWithKeyValues:response];
        success(user);
    } failure:^(NSError *error, long statusCode) {
        failure();
    }];
}

@end
