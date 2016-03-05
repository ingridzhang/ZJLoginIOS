
#import <Foundation/Foundation.h>

@interface RkyForgetPasswordModel : NSObject

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *msg_en;
@property (nonatomic, strong) NSString *status_code;
@property (nonatomic, strong) NSString *debug;

- (instancetype)initWithJSON:(NSDictionary *)JSON;

@end
