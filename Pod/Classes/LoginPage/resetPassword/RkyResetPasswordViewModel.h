//
//  RkyResetPasswordViewModel.h
//  EasyJieApp
//
//  Created by sun on 15/7/28.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@class RkyForgetPasswordViewModel;

@interface RkyResetPasswordViewModel : NSObject

- (instancetype)initWithViewModel:(RkyForgetPasswordViewModel *)forgetPasswordViewModel;

// 密码
@property (nonatomic, strong) NSString *password;
// 确认按钮操作
@property (nonatomic, readonly) RACCommand *verifiedCommand;
// 是否显示密码
@property (nonatomic, readonly) RACCommand *showPasswordCommand;

@end
