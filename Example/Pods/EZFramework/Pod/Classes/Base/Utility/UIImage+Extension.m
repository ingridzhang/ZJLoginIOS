//
//  UIImage+Extension.m
//  照片选择
//
//  Created by apple on 15/9/2.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
- (UIImage *)scaleImage:(CGFloat)width {
    CGFloat height = self.size.height * width / self.size.width;
    CGSize s = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(s);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
