
#import <UIKit/UIKit.h>
#import "LoginHeader.h"

@interface UIFont (RkySkin)

+ (instancetype) fontForModule:(NSString *)module target:(NSString *)target;
+ (instancetype) fontForModule:(NSString *)module target:(NSString *)target skinStyle:(RkySkinStyle) skinStyle;
@end
