//
//  RkyForgetPasswordViewModel.m
//  EasyJieApp
//
//  Created by sun on 15/7/24.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "RkyForgetPasswordViewModel.h"
#import "RkyForgetPasswordModel.h"
#import "RkyLoginService.h"
#import "LoginHeader.h"

@interface RkyForgetPasswordViewModel ()

@property (nonatomic, readwrite) BOOL validUserName;
@property (nonatomic, readwrite) RACCommand *verifiedCommand;
@property (nonatomic, readwrite) RACCommand *getVerifionCodeCommand;
@property (nonatomic, readwrite) RACCommand *getVerifionCodeCommandExecuted;
@property (nonatomic, readwrite) NSUInteger type;

@end

@implementation RkyForgetPasswordViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self)
        RACSignal *validUserNameSignal = [[[RACObserve(self, userName) map:^id(NSString *userName) {
            @strongify(self)
            return @([self validUserName:userName]);
        }] distinctUntilChanged] doNext:^(id x) {
            self.type = 0;
        }];
        RAC(self, validUserName) = validUserNameSignal;
        
        RACSignal *validPasswordSignal = [[RACObserve(self, veryfyCode) map:^id(NSString *veryfyCode) {
            @strongify(self)
            return @([self validVerifitionCode:veryfyCode]);
        }] distinctUntilChanged];
        
        RACSignal *validSignal = [RACSignal combineLatest:@[validUserNameSignal, validPasswordSignal]
                                                   reduce:^id(NSNumber *userValid, NSNumber *passwordValid){
                                                       return @([userValid boolValue] && [passwordValid boolValue]);
                                                   }];
        
        self.verifiedCommand = [[RACCommand alloc] initWithEnabled:validSignal signalBlock:^RACSignal *(id input) {
            @strongify(self)
            if ([self validEmail:self.userName]) {
                return [self requestCheckEmailCode];
            } else {
                return [self requestChecksmscode];
            }
        }];
        
        self.getVerifionCodeCommand = [[RACCommand alloc] initWithEnabled:validUserNameSignal
                                                              signalBlock:^RACSignal *(id input) {
                                                                  @strongify(self)
                                                                  if ([self validEmail:self.userName]) {
                                                                      return [self requestSendEmail];
                                                                  } else {
                                                                      RACSignal *signal = [self requestSendsmscodeWithType:self.type];
                                                                      self.type = 1;
                                                                      return signal;
                                                                  }
                                                              }];
        
        self.getVerifionCodeCommandExecuted = [[RACCommand alloc] initWithEnabled:[RACSignal return:@NO]
                                                                      signalBlock:^RACSignal *(id input) {
                                                                          return [RACSignal empty];
                                                                      }];
    }
    return self;
}

- (void)dealloc {

}

- (NSString *)phoneNum {
    return [self validPhoneNumber:self.userName] ? self.userName : @"";
}

- (NSString *)email {
    return [self validEmail:self.userName] ? self.userName : @"";
}

//验证用户名是不是邮箱或者手机号
- (BOOL)validUserName:(NSString *)userName {
    return [self validPhoneNumber:userName] || [self validEmail:userName];
}

// 验证邮箱
- (BOOL)validEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 验证手机号是否是11位数字
- (BOOL)validPhoneNumber:(NSString *)phoneNum {
    NSString *phoneNumRegex = @"^\\d{11}$";
    NSPredicate *phoneNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumRegex];
    return [phoneNumTest evaluateWithObject:phoneNum];
}

// 验证验证码是否是6位数字
- (BOOL)validVerifitionCode:(NSString *)verifitionCode {
    NSString *verifitionCodeRegex = @"^\\d{6}$";
    NSPredicate *verifitionCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifitionCodeRegex];
    return [verifitionCodeTest evaluateWithObject:verifitionCode];
}

// 请求验证码短信或者语音
- (RACSignal *)requestSendsmscodeWithType:(NSInteger)type {
    @weakify(self)
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [RkyLoginService sendSMSCode:@{@"mobile":self.userName, @"type":[@(type) stringValue], @"from":@"1"} success:^(RkyForgetPasswordModel *model) {
            if ([model.status_code integerValue] == 200) {
                model.msg = @"验证码已发送，请注意查收";
            }
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } failure:^{
            NSError *error = [NSError errorWithDomain:@"网络异常，请稍后重试" code:0 userInfo:nil];
            [subscriber sendError:error];
        }];
        return nil;
//        AFJSONRequestOperation *opertaion = [RkyLoginPageRequest
//                                             requestSendsmscodeWithMobileFromForgetPassword:self.userName
//                                             type:type
//                                             Success:^(RkyForgetPasswordModel *model){
//                                                 if ([model.status_code integerValue] == 200) {
//                                                     model.msg = @"验证码已发送，请注意查收";
//                                                 }
//                                                 [subscriber sendNext:model];
//                                                 [subscriber sendCompleted];
//                                             } Failure:^(NSString *msg) {
//                                                 NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
//                                                 [subscriber sendError:error];
//                                             }];
//        return [RACDisposable disposableWithBlock:^{
//            [opertaion cancel];
//        }];
    }] publish] autoconnect];
}

// 请求邮件验证码
- (RACSignal *)requestSendEmail {
    @weakify(self)
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [RkyLoginService sendEmail:@{@"email":self.userName, @"from":@"1"} success:^(RkyForgetPasswordModel *model) {
            if ([model.status_code integerValue] == 200) {
                model.msg = @"验证码已发送至邮箱，未收到请查看垃圾邮件";
            }
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } failure:^{
            NSError *error = [NSError errorWithDomain:@"网络异常，请稍后重试" code:0 userInfo:nil];
            [subscriber sendError:error];
        }];
        return nil;
//        AFJSONRequestOperation *operation = [RkyLoginPageRequest requestSendEmailWithEmail:self.userName Success:^(RkyForgetPasswordModel *model) {
//            if ([model.status_code integerValue] == 200) {
//                model.msg = @"验证码已发送至邮箱，未收到请查看垃圾邮件";
//            }
//            [subscriber sendNext:model];
//            [subscriber sendCompleted];
//        } Failure:^(NSString *msg) {
//            NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
//            [subscriber sendError:error];
//        }];
//        return [RACDisposable disposableWithBlock:^{
//            [operation cancel];
//        }];
    }] publish] autoconnect];
}

// 检查手机号与验证码是否匹配
- (RACSignal *)requestChecksmscode {
    @weakify(self)
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [RkyLoginService checkSMSCode:@{@"mobile":self.userName, @"verify_code":self.veryfyCode} success:^(RkyForgetPasswordModel *model) {
            if ([model.status_code integerValue] == 200) {
                model.msg = @"验证码正确";
            }
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } failure:^{
            NSError *error = [NSError errorWithDomain:@"网络异常，请稍后重试" code:0 userInfo:nil];
            [subscriber sendError:error];
        }];
        return nil;
        
//        AFJSONRequestOperation *operation = [RkyLoginPageRequest requestChecksmscodeWithMobile:self.userName verifyCode:self.veryfyCode Success:^(RkyForgetPasswordModel *model) {
//            if ([model.status_code integerValue] == 200) {
//                model.msg = @"验证码正确";
//            }
//            [subscriber sendNext:model];
//            [subscriber sendCompleted];
//        } Failure:^(NSString *msg) {
//            NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
//            [subscriber sendError:error];
//        }];
//        return [RACDisposable disposableWithBlock:^{
//            [operation cancel];
//        }];
    }] publish] autoconnect];
}

// 检查邮箱以及验证码是否匹配
- (RACSignal *)requestCheckEmailCode {
    @weakify(self)
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [RkyLoginService checkEmail:@{@"email":self.userName, @"verify_code":self.veryfyCode} success:^(RkyForgetPasswordModel *model) {
            if ([model.status_code integerValue] == 200) {
                model.msg = @"验证码正确";
            }
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        } failure:^{
            NSError *error = [NSError errorWithDomain:@"网络异常，请稍后重试" code:0 userInfo:nil];
            [subscriber sendError:error];
        }];
        return nil;
//        [RkyLoginPageRequest requestCheckEmailWithEmail:self.userName verifyCode:self.veryfyCode Success:^(RkyForgetPasswordModel *model) {
//            if ([model.status_code integerValue] == 200) {
//                model.msg = @"验证码正确";
//            }
//            [subscriber sendNext:model];
//            [subscriber sendCompleted];
//        } Failure:^(NSString *msg) {
//            NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
//            [subscriber sendError:error];
//        }];
//        return nil;
    }] publish] autoconnect];
}

@end
