//
//  RkyResetPasswordViewModel.m
//  EasyJieApp
//
//  Created by sun on 15/7/28.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "RkyResetPasswordViewModel.h"
#import "RkyForgetPasswordViewModel.h"
#import "RkyForgetPasswordModel.h"
#import "RkyLoginService.h"
#import "LoginHeader.h"

@interface RkyResetPasswordViewModel ()

@property (nonatomic, strong) RkyForgetPasswordViewModel *forgetPasswordViewModel;
// 确认按钮操作
@property (nonatomic, readwrite) RACCommand *verifiedCommand;
// 是否显示密码
@property (nonatomic, readwrite) RACCommand *showPasswordCommand;

@end

@implementation RkyResetPasswordViewModel

- (instancetype)initWithViewModel:(RkyForgetPasswordViewModel *)forgetPasswordViewModel {
    self = [super init];
    if (self) {
        
        self.forgetPasswordViewModel = forgetPasswordViewModel;
        
        RACSignal *passwordSignal = [RACObserve(self, password) map:^id(NSString *password) {
            return @([password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length >= 6);
        }];
        self.verifiedCommand = [[RACCommand alloc] initWithEnabled:passwordSignal signalBlock:^RACSignal *(id input) {
            return [self requestResetPassword];
        }];
        
        self.showPasswordCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
    }
    return self;
}

- (RACSignal *)requestResetPassword {
    @weakify(self)
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [RkyLoginService resetPassword:@{@"new_password":self.password, @"verify_code":self.forgetPasswordViewModel.veryfyCode, @"mobile":self.forgetPasswordViewModel.phoneNum, @"email":self.forgetPasswordViewModel.email} success:^(RkyForgetPasswordModel *model) {
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } failure:^{
            NSError *error = [[NSError alloc] initWithDomain:@"网络异常，请稍后重试" code:0 userInfo:nil];
            [subscriber sendError:error];
        }];
        return nil;
//        AFJSONRequestOperation *operation = [RkyLoginPageRequest
//                                             requestResetPasswordWithNewPassword:self.password
//                                             verifyCode:self.forgetPasswordViewModel.veryfyCode
//                                                mobile:self.forgetPasswordViewModel.phoneNum
//                                                email:self.forgetPasswordViewModel.email
//                                                Success:^(RkyForgetPasswordModel *model) {
//                                                    [subscriber sendNext:model];
//                                                    [subscriber sendCompleted];
//                                                } Failure:^(NSString *msg) {
//                                                    NSError *error = [[NSError alloc] initWithDomain:msg code:0 userInfo:nil];
//                                                    [subscriber sendError:error];
//                                                }];
//        return [RACDisposable disposableWithBlock:^{
//            [operation cancel];
//        }];
    }] publish] autoconnect];
}

@end
