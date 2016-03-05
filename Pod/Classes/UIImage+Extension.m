
#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (instancetype)bundleImage:(NSString *)imageName bundleClass:(Class)bundleClass bundleName:(NSString *)bundleName {
    
    NSString *bundlePath = [[NSBundle bundleForClass:bundleClass]
                            pathForResource:bundleName ofType:@"bundle"];
    NSString *path = [NSString stringWithFormat:@"%@/%@",bundlePath,imageName];
    UIImage *imagee = [UIImage imageWithContentsOfFile:path];
    return imagee;
}

@end
