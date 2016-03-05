//
//  EZRequestAndDataMapping.m
//  EZFramework_example
//
//  Created by sun on 15/10/9.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZRequestAndDataMapping.h"
#import "EZHTTPRequestManager.h"
#import "EZCollectionDefault.h"
#import "MJExtension.h"
#import "EZDBHelper.h"

@implementation EZRequestAndDataMapping

// 使用这些方法，不会将数据进行持久化
+ (NSURLSessionDataTask *)POST:(NSString *)url
  modelClass:(Class)ModelClass
  parameters:(NSDictionary *)parameters
     success:(void(^)(id model))success
     failure:(void(^)(NSError *error, long statusCode))failure {
    return [EZHTTPRequestManager POST:url headers:[EZCollectionDefault shareInstance].header body:parameters completion:^(NSDictionary *responseDic) {
        [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = [responseDic[@"is_login"] boolValue];
        [EZCollectionDefault shareInstance].isCommunityBanned = [responseDic[@"is_community_banned"] boolValue];
        // 如果传入了类类型，表明需要转换为model返回, 否则，直接将请求的数据返回
        if (ModelClass) {
            id instance = [self dictionaryToModelWithDictionary:responseDic[@"data"] modelClass:ModelClass persistence:NO parameters:nil];
            if (instance) {
                success ? success(instance) : nil;
            } else {
                NSError *error = [NSError errorWithDomain:@"数据无法转换为模型" code:0 userInfo:nil];
                failure ? failure(error, 0) : nil;
            }
        } else {
            success ? success(responseDic) : nil;
        }
    } failure:^(NSError *error, long responseCode) {
        // 网络请求异常/超时/json解析错误 时候的处理
        if (failure) {
            failure(error, responseCode);
        }
    }];
}

+ (NSURLSessionDataTask *)GET:(NSString *)url
 modelClass:(Class)ModelClass
 parameters:(NSDictionary *)parameters
    success:(void(^)(id model))success
    failure:(void(^)(NSError *error, long statusCode))failure {
    return [EZHTTPRequestManager GET:url parameters:parameters headers:[EZCollectionDefault shareInstance].header completion:^(NSDictionary *responseDic) {
        [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = [responseDic[@"is_login"] boolValue];
        [EZCollectionDefault shareInstance].isCommunityBanned = [responseDic[@"is_community_banned"] boolValue];
        // 如果传入了类类型，表明需要转换为model返回, 否则，直接将请求的数据返回
        if (ModelClass) {
            id instance = [self dictionaryToModelWithDictionary:responseDic[@"data"] modelClass:ModelClass persistence:NO parameters:nil];
            if (instance) {
                success ? success(instance) : nil;
            } else {
                NSError *error = [NSError errorWithDomain:@"数据无法转换为模型" code:0 userInfo:nil];
                failure ? failure(error, 0) : nil;
            }
        } else {
            success ? success(responseDic) : nil;
        }
        
    } failure:^(NSError *error, long responseCode) {
        // 网络请求异常/超时/json解析错误 时候的处理
        if (failure) {
            failure(error, responseCode);
        }
    }];
}

+ (NSURLSessionDataTask *)DELETE:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(void(^)(id model))success
       failure:(void(^)(NSError *error, long statusCode))failure {
    return [EZHTTPRequestManager DELETE:url parameters:parameters headers:[EZCollectionDefault shareInstance].header completion:^(NSDictionary *responseDic) {
        [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = [responseDic[@"is_login"] boolValue];
        success ? success(responseDic) : nil;
    } failure:^(NSError *error, long responseCode) {
        if (failure) {
            failure(error, responseCode);
        }
    }];
}

// 之后的这两个方法，会将数据进行持久化操作
+ (NSURLSessionDataTask *)POSTForPersistence:(NSString *)url
                modelClass:(Class)ModelClass
                parameters:(NSDictionary *)parameters
                   success:(void(^)(id model))success
                   failure:(void(^)(NSError *error, long statusCode))failure {
    return [EZHTTPRequestManager POST:url headers:[EZCollectionDefault shareInstance].header body:parameters completion:^(NSDictionary *responseDic) {
        [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = [responseDic[@"is_login"] boolValue];
        [EZCollectionDefault shareInstance].isCommunityBanned = [responseDic[@"is_community_banned"] boolValue];
        // 如果传入了类类型，表明需要转换为model返回, 否则，直接将请求的数据返回
        if (ModelClass) {
            id instance = [self dictionaryToModelWithDictionary:responseDic[@"data"] modelClass:ModelClass persistence:YES parameters:parameters];
            if (instance) {
                success ? success(instance) : nil;
            } else {
                NSError *error = [NSError errorWithDomain:@"数据无法转换为模型" code:0 userInfo:nil];
                failure ? failure(error, 0) : nil;
            }
        } else {
            success ? success(responseDic) : nil;
        }
    } failure:^(NSError *error, long responseCode) {
        // 网络请求异常/超时/json解析错误 时候的处理
        if (failure) {
            failure(error, responseCode);
        }
    }];
}

+ (NSURLSessionDataTask *)GETForPersistence:(NSString *)url
               modelClass:(Class)ModelClass
               parameters:(NSDictionary *)parameters
                  success:(void(^)(id model))success
                  failure:(void(^)(NSError *error, long statusCode))failure {
    return [EZHTTPRequestManager GET:url parameters:parameters headers:[EZCollectionDefault shareInstance].header completion:^(NSDictionary *responseDic) {
        [EZCollectionDefault shareInstance].isLoginedAtCurrentRequest = [responseDic[@"is_login"] boolValue];
        [EZCollectionDefault shareInstance].isCommunityBanned = [responseDic[@"is_community_banned"] boolValue];
        // 如果传入了类类型，表明需要转换为model返回, 否则，直接将请求的数据返回
        if (ModelClass) {
            id instance = [self dictionaryToModelWithDictionary:responseDic[@"data"] modelClass:ModelClass persistence:YES parameters:parameters];
            if (instance) {
                success ? success(instance) : nil;
            } else {
                NSError *error = [NSError errorWithDomain:@"数据无法转换为模型" code:0 userInfo:nil];
                failure ? failure(error, 0) : nil;
            }
        } else {
            success ? success(responseDic) : nil;
        }
        
    } failure:^(NSError *error, long responseCode) {
        // 网络请求异常/超时/json解析错误 时候的处理
        if (failure) {
            failure(error, responseCode);
        }
    }];
}

// 模型映射
+ (id)dictionaryToModelWithDictionary:(NSDictionary *)dictionary
                           modelClass:(Class)ModelClass
                          persistence:(BOOL)isPersistence
                           parameters:(NSDictionary *)parameters
{
    id instance = nil;
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        instance = [ModelClass mj_objectWithKeyValues:dictionary];
    } else if ([dictionary isKindOfClass:[NSArray class]]) {
        instance = [ModelClass mj_objectArrayWithKeyValuesArray:dictionary];
    }
    if (![instance isKindOfClass:ModelClass] && ![instance isKindOfClass:[NSArray class]]) {
        instance = nil;
    }
    if (isPersistence) {
        if ([instance isKindOfClass:ModelClass]) {
            [instance mj_setKeyValues:parameters];
            [[EZDBHelper defaultLKDBHelper] insertToDB:instance];
        } else if ([instance isKindOfClass:[NSArray class]]) {
            [[EZDBHelper defaultLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
                BOOL success = NO;
                for (id model in instance) {
                    success = [[EZDBHelper defaultLKDBHelper] insertToDB:model];
                }
                return success;
            }];
        }
        
    }
    return instance;
}

@end
