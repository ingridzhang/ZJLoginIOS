//
//  UIButton+Extension.h
//  MyNewBlog
//
//  Created by apple on 15/8/19.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
- (instancetype)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;
- (instancetype)initWithImage:(NSString *)imageName backImage:(NSString *)backImageName title:(NSString *)title;
- (void)setImage:(NSString *)imageName andBackImage:(NSString *)backImageName title:(NSString *)title;
@end
