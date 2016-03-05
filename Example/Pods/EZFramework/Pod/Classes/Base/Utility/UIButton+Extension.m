//
//  UIButton+Extension.m
//  MyNewBlog
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (instancetype)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize {
    if (self = [super init]) {
        [self setTitle:title forState:(UIControlStateNormal)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [self setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithImage:(NSString *)imageName backImage:(NSString *)backImageName title:(NSString *)title
{
    self = [super init];
    if (self) {
        [self setImage:imageName andBackImage:backImageName title:title];
    }
    return self;
}

- (void)setImage:(NSString *)imageName andBackImage:(NSString *)backImageName title:(NSString *)title {
    if (imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    }
    if (backImageName) {
        [self setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",backImageName]] forState:UIControlStateHighlighted];
    }
    if (title) {
        [self setTitle:title forState:UIControlStateNormal];
    }
}

@end
