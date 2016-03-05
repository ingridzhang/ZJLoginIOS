//
//  UILabel+Extension.m
//  MyNewBlog
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (instancetype)initWithColor: (UIColor *)color fontSize: (CGFloat)fontSize {
    if (self = [super init]) {
        [self setTextColor:color];
        [self setFont:[UIFont systemFontOfSize:fontSize]];
    }
    return self;
}
@end
