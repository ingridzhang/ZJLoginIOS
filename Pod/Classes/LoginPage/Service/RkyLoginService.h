
#import <Foundation/Foundation.h>

@interface RkyLoginService : NSObject

+ (void)sendSMSCodeFromForgetPassword:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)sendSMSCode:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)sendEmail:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)checkSMSCode:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)checkEmail:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)resetPassword:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)registerUser:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (NSURLSessionDataTask *)login:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(NSError *error))failure;

+ (void)getAgreementSuccess:(void(^)(id model))success failure:(void(^)(void))failure;

+ (void)logoutSuccess:(void(^)(id model))success failure:(void(^)(void))failure;

+ (NSURLSessionDataTask *)weChatLogin:(NSDictionary *)parameters success:(void(^)(id model))success failure:(void(^)(NSError *error))failure;

+ (NSURLSessionDataTask *)getAccessToken:(NSString *)code success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (NSURLSessionDataTask *)refreshAccessToken:(NSString *)refreshToken success:(void(^)(id model))success failure:(void(^)(void))failure;

+ (NSURLSessionDataTask *)getWeChatUserInfo:(NSString *)accessToken openId:(NSString *)openId success:(void(^)(id model))success failure:(void(^)(void))failure;

@end
