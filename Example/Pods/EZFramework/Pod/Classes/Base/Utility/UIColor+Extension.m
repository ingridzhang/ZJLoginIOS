//
//  UIColor+Extension.m
//  MyNewBlog
//
//  Created by apple on 15/9/2.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1.0];
}
+ (CGFloat)randomValue {
    return arc4random_uniform(256)/255.0;
}

@end
