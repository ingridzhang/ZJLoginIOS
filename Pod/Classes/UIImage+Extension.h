//
//  UIImage+Extension.h
//  Pods
//
//  Created by Apple on 16/1/22.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (instancetype)bundleImage:(NSString *)imageName bundleClass:(Class)bundleClass bundleName:(NSString *)bundleName;

@end
