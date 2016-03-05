//
//  HTTPRequestManager.m
//  EasyJieApp
//
//  Created by sun on 15/8/25.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "EZHTTPRequestManager.h"
#import <UIKit/UIKit.h>

@implementation EZHTTPRequestManager

+ (NSURLSessionDataTask *)requestWithRequest:(NSURLRequest *)request
                    header:(NSDictionary *)header
                completion:(void(^)(NSDictionary *responseDic))completion
                   failure:(void(^)(NSError *error, long responseCode))failure {
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configure setHTTPAdditionalHeaders:header];
    [configure setTimeoutIntervalForRequest:20.0f];
    [configure setTimeoutIntervalForResource:20.0f];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                        if (!error) {
                            NSError *jsonError = nil;
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:NSJSONReadingAllowFragments
                                                                                  error:&jsonError];
                            
                            if (jsonError) {
                                NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                NSLog(@"s=%@", s);
                                failure(jsonError, httpResponse.statusCode);
                            } else {
                                completion(dic);
                            }
                        } else {
                            failure(error, httpResponse.statusCode);
                        }
                    });
                }];
    [sessionDataTask resume];
    return sessionDataTask;
}

+ (NSURLSessionDataTask *)POST:(NSString *)url
     headers:(NSDictionary *)header
        body:(id)body
  completion:(void(^)(NSDictionary *responseDic))completion
     failure:(void(^)(NSError *error, long responseCode))failure {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self buildBody:body]];
    return [self requestWithRequest:request header:header completion:^(NSDictionary *responseDic) {
        completion(responseDic);
    } failure:^(NSError *error, long responseCode) {
        failure(error, responseCode);
    }];
}

+ (NSURLSessionDataTask *)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
    headers:(NSDictionary *)header
 completion:(void(^)(NSDictionary *responseDic))completion
    failure:(void(^)(NSError *error, long responseCode))failure {
    url = [url stringByAppendingString:[self buildQueryString:parameters]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    [request setHTTPMethod:@"GET"];
    return [self requestWithRequest:request header:header completion:^(NSDictionary *responseDic) {
        completion(responseDic);
    } failure:^(NSError *error, long responseCode) {
        failure(error, responseCode);
    }];
}

+ (NSURLSessionDataTask *)DELETE:(NSString *)url
    parameters:(NSDictionary *)parameters
       headers:(NSDictionary *)header
    completion:(void(^)(NSDictionary *responseDic))completion
       failure:(void(^)(NSError *error, long responseCode))failure {
    url = [url stringByAppendingString:[self buildQueryString:parameters]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    [request setHTTPMethod:@"DELETE"];
    return [self requestWithRequest:request header:header completion:^(NSDictionary *responseDic) {
        completion(responseDic);
    } failure:^(NSError *error, long responseCode) {
        failure(error, responseCode);
    }];
}

+ (NSString *)buildQueryString:(NSDictionary *)parameters {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in parameters) {
        [array addObject:[key stringByAppendingFormat:@"=%@", parameters[key]]];
    }
    return [array.count > 0 ? @"?" : @"" stringByAppendingString:[array componentsJoinedByString:@"&"]];
}

+ (NSData *)buildBody:(NSDictionary *)parameters {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in parameters) {
        [array addObject:[key stringByAppendingFormat:@"=%@", parameters[key]]];
    }
    return [[array componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
}

@end
