//
//  HTTPRequestManager.h
//  EasyJieApp
//
//  Created by sun on 15/8/25.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZHTTPRequestManager : NSObject

+ (NSURLSessionDataTask *)POST:(NSString *)url
     headers:(NSDictionary *)header
        body:(id)body
  completion:(void(^)(NSDictionary *responseDic))completion
     failure:(void(^)(NSError *error, long responseCode))failure;

+ (NSURLSessionDataTask *)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
    headers:(NSDictionary *)header
 completion:(void(^)(NSDictionary *responseDic))completion
    failure:(void(^)(NSError *error, long responseCode))failure;

+ (NSURLSessionDataTask *)DELETE:(NSString *)url
    parameters:(NSDictionary *)parameters
       headers:(NSDictionary *)header
    completion:(void(^)(NSDictionary *responseDic))completion
       failure:(void(^)(NSError *error, long responseCode))failure;

@end
