
#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RkyForgetPasswordViewModel : NSObject

// 用户名：邮箱或者手机号，需要加验证，可以使用正则表达式
@property (nonatomic, strong) NSString *userName;
// 验证码
@property (nonatomic, strong) NSString *veryfyCode;
// 验证账号以及验证码
@property (nonatomic, readonly) RACCommand *verifiedCommand;
// 获取验证码
@property (nonatomic, readonly) RACCommand *getVerifionCodeCommand;
// 获取验证码按钮点击后
@property (nonatomic, readonly) RACCommand *getVerifionCodeCommandExecuted;
// 用户名是否有效
@property (nonatomic, readonly) BOOL validUserName;
// 获取手机，当用户名是手机号时，返回username，否则返回空
@property (nonatomic, readonly) NSString *phoneNum;
// 获取邮箱，当用户名是邮箱时，返回邮箱，否则返回空
@property (nonatomic, readonly) NSString *email;
// 语音验证码类型,1为语音验证码，0为短信或者邮件验证码
@property (nonatomic, readonly) NSUInteger type;

@end
