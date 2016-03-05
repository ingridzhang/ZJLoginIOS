//
//  EZRequestAndDataMapping.h
//  EZFramework_example
//
//  Created by sun on 15/10/9.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZRequestAndDataMapping : NSObject

// 使用这些方法，不会将数据进行持久化
+ (NSURLSessionDataTask *)POST:(NSString *)url
  modelClass:(Class)ModelClass
  parameters:(NSDictionary *)parameters
     success:(void(^)(id model))success
     failure:(void(^)(NSError *error, long statusCode))failure;

+ (NSURLSessionDataTask *)GET:(NSString *)url
 modelClass:(Class)ModelClass
 parameters:(NSDictionary *)parameters
    success:(void(^)(id model))success
    failure:(void(^)(NSError *error, long statusCode))failure;

+ (NSURLSessionDataTask *)DELETE:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(void(^)(id model))success
       failure:(void(^)(NSError *error, long statusCode))failure;

// 之后的这两个方法，会将数据进行持久化操作
+ (NSURLSessionDataTask *)POSTForPersistence:(NSString *)url
                modelClass:(Class)ModelClass
                parameters:(NSDictionary *)parameters
                   success:(void(^)(id model))success
                   failure:(void(^)(NSError *error, long statusCode))failure;

+ (NSURLSessionDataTask *)GETForPersistence:(NSString *)url
               modelClass:(Class)ModelClass
               parameters:(NSDictionary *)parameters
                  success:(void(^)(id model))success
                  failure:(void(^)(NSError *error, long statusCode))failure;

@end
