
#import <UIKit/UIKit.h>
#import "LoginHeader.h"

@interface UIImage (RkySkin)

+ (instancetype)imageForKey: (NSString *)key;
+ (instancetype)imageForKey: (NSString *)key skinStyle:(RkySkinStyle) skinStyle;
+ (instancetype)imageForKey: (NSString *)key skinStyle:(RkySkinStyle) skinStyle cache:(BOOL)cache;

@end
