
#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface RkyWeixinHandler : NSObject <WXApiDelegate>

+ (instancetype) sharedInstance;
-(void)loginWithSuccess:(void(^)(id model))success failure:(void(^)(NSError *error))failrue;
- (void)loginOutWithSuccess:(void(^)(id model))success failure:(void (^)(void))failure;
@property (nonatomic,strong) Class MobClick;
@end
