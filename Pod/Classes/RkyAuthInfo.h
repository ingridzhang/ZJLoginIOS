
#import <Foundation/Foundation.h>

@interface RkyAuthInfo : NSObject
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, assign) NSInteger expireSec;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *openID;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, strong) NSDate *lastRefresh;

@end
