
#import <Foundation/Foundation.h>

@interface RkyMailHandler : NSObject

+ (instancetype)sharedInstance;

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(id model))success failure:(void(^)(NSError *error))failure;
- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void(^)(id model))success failure:(void(^)(NSError *error))failure;
- (void)loginOutWithSuccess:(void(^)(id model))success failure:(void (^)(void))failure;

@end
