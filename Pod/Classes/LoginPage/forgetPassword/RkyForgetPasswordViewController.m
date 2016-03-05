//
//  RkyForgetPasswordViewController.m
//  EasyJieApp
//
//  Created by sun on 15/7/24.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "RkyForgetPasswordViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RkyForgetPasswordViewModel.h"
#import "RkyCustomTextField.h"
#import "RkyForgetPasswordModel.h"
#import "RkyResetPasswordViewController.h"
#import "ASLoginViewFrameDefine.h"
#import "UIImage+Extension.h"

@interface RkyForgetPasswordViewController ()

@property (nonatomic, strong) RkyForgetPasswordViewModel *forgetPasswordViewModel;
// 用户账户
@property (nonatomic, strong) UITextField *mailTextField;
// 密码
@property (nonatomic, strong) UITextField *passwordTextField;

// 用户账户以及密码背景图片
@property (nonatomic, strong) UIImageView *emailImageView;
@property (nonatomic, strong) UIImageView *passworldImageView;

// 获取验证码
@property (nonatomic, strong) UIButton *getVerifitionCodeBtn;
// 确认按钮
@property (nonatomic, strong) UIButton *verifiedBtn;
// 返回上一页按钮
@property (nonatomic, strong) UIButton *backButton;

// 背景图片
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;

// 容器视图，用于包含输入框以及确认按钮，方便动画
@property (nonatomic, strong) UIView *containerView;
// 该页面将要消失的信号
@property (nonatomic, strong) RACSignal *disappearSignal;
@property (nonatomic, strong) RACSignal *netivitySignal;

@end

@implementation RkyForgetPasswordViewController

- (void)dealloc {

}

- (instancetype)initWithUserName:(NSString *)userName {
    self = [super init];
    if (self) {
        self.forgetPasswordViewModel.userName = userName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.logoImageView];
    
    [self.containerView addSubview:self.emailImageView];
    [self.emailImageView addSubview:self.mailTextField];
    [self.containerView addSubview:self.passworldImageView];
    [self.passworldImageView addSubview:self.passwordTextField];
    [self.containerView addSubview:self.verifiedBtn];
    [self.containerView addSubview:self.getVerifitionCodeBtn];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.backButton];
    
    @weakify(self)
    // 点击北京键盘收回
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:tapGesture];
    [[tapGesture rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self resignAllTextFieldFirstResponder];
    }];
    // 增加键盘出现，操作框
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(NSNotification *notification) {
        @strongify(self)
         NSValue *value = [notification userInfo][UIKeyboardFrameEndUserInfoKey];
         CGSize size = [value CGRectValue].size;
         [self changeHeightWithKeyboradHeight:size.height];
         [self showLogo:NO];
    }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        [self changeHeightWithKeyboradHeight:0];
         [self showLogo:YES];
    }];
    
    // 界面即将消失
    self.disappearSignal = [[self rac_signalForSelector:@selector(viewWillDisappear:)] mapReplace:@(YES)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:NSStringFromClass([self class])];
//    [self.MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:NSStringFromClass([self class])];
//    [self.MobClick endLogPageView:NSStringFromClass([self class])];
}

- (UIImageView *)emailImageView {
    if (!_emailImageView) {
//        _emailImageView=[[UIImageView alloc]initWithFrame:CGRectMake(35, 7, 502/2, 47/2)];
        _emailImageView=[[UIImageView alloc]initWithFrame:CGRECTMAKE(FORGETPASSWORD_EMAILIMAGEVIEW_LEFT, FORGETPASSWORD_EMAILIMAGEVIEW_TOP, FORGETPASSWORD_EMALEIMAGEVIEW_WIDTH, FORGETPASSWORD_EMALEIMAGEVIEW_HEIGHT)];
        _emailImageView.centerX = self.view.width / 2;
        _emailImageView.userInteractionEnabled = YES;
        [_emailImageView setImage:[UIImage bundleImage:@"loginYouXiang.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
    }
    return _emailImageView;
}

- (UIImageView *)passworldImageView {
    if (!_passworldImageView) {
        _passworldImageView=[[UIImageView alloc]initWithFrame:CGRECTMAKE(FORGETPASSWORD_PASSWORDIMAGEVIEW_LEFT, FORGETPASSWORD_PASSWORDIMAGEVIEW_TOP, FORGETPASSWORD_PASSWORDIMAGEVIEW_WIDTH, FORGETPASSWORD_PASSWORDIMAGEVIEW_HEIGHT)];
        _passworldImageView.centerX = self.view.width / 2;
        _passworldImageView.userInteractionEnabled = YES;
        [_passworldImageView setImage:[UIImage bundleImage:@"loginYanzhengma.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
    }
    return _passworldImageView;
}

- (UITextField *)mailTextField {
    if (!_mailTextField) {
        _mailTextField = [[RkyCustomTextField alloc] initWithFrame:CGRECTMAKE(FORGETPASSWORD_MAILTEXTFILED_LEFT, FORGETPASSWORD_MAILTEXTFILED_TOP, FORGETPASSWORD_MAILTEXTFILED_WIDTH, FORGETPASSWORD_MAILTEXTFILED_HEIGHT)];
        _mailTextField.centerY = self.emailImageView.height / 2 - SCREEN_RADIO * 7;
        _mailTextField.placeholder = @"请输入手机号/邮箱号";
        _mailTextField.backgroundColor = [UIColor clearColor];
        _mailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _mailTextField.textColor=[UIColor whiteColor];
        _mailTextField.text = self.forgetPasswordViewModel.userName;
        _mailTextField.font =[UIFont boldSystemFontOfSize:16];
        _mailTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        @weakify(self)
        RAC(self.forgetPasswordViewModel, userName) = [self.mailTextField.rac_textSignal doNext:^(id x) {
            @strongify(self)
            if ([self.getVerifitionCodeBtn.titleLabel.text isEqualToString:@"获取语音验证码"]) {
                [self.getVerifitionCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            }
        }];
    }
    return _mailTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
//        _passwordTextField = [[RkyCustomTextField alloc] initWithFrame:CGRECTMAKE(21.5, 0, 251 - 120 - 21.5 - 5, 23.5)];
        _passwordTextField = [[RkyCustomTextField alloc] initWithFrame:CGRECTMAKE(FORGETPASSWORD_PASSWORDTEXTFILED_LEFT, FORGETPASSWORD_PASSWORDTEXTFILED_TOP, FORGETPASSWORD_PASSWORDTEXTFILED_WIDTH, FORGETPASSWORD_PASSWORDTEXTFILED_HEIGHT)];
        _passwordTextField.centerY = self.passworldImageView.height / 2 - 7 * SCREEN_RADIO;
        _passwordTextField.backgroundColor = [UIColor clearColor];
        _passwordTextField.placeholder = @"请输入验证码";
        [_passwordTextField setTextColor:[UIColor whiteColor]];
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.text = @"";
        _passwordTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        RAC(self.forgetPasswordViewModel, veryfyCode) = self.passwordTextField.rac_textSignal;
    }
    return _passwordTextField;
}

- (UIButton *)getVerifitionCodeBtn {
    if (!_getVerifitionCodeBtn) {
        // 初始化获取验证码按钮
        _getVerifitionCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getVerifitionCodeBtn.frame = CGRECTMAKE(FORGETPASSWORD_VERIFITIONCODEBTN_LEFT, FORGETPASSWORD_VERIFITIONCODEBTN_TOP, FORGETPASSWORD_VERIFITIONCODEBTN_WIDTH, FORGETPASSWORD_VERIFITIONCODEBTN_HEIGHT);
        _getVerifitionCodeBtn.centerY = self.passwordTextField.centerY;
        [_getVerifitionCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifitionCodeBtn setTitleColor:[UIColor colorWithHexString:@"#FFB200"] forState:UIControlStateNormal];
        _getVerifitionCodeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_getVerifitionCodeBtn setBackgroundImage:[[UIImage bundleImage:@"btn_Image.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
        _getVerifitionCodeBtn.right = self.passworldImageView.right;
        _getVerifitionCodeBtn.bottom = self.passworldImageView.bottom-6;
        // 设置获取验证码的动作
        _getVerifitionCodeBtn.rac_command = self.forgetPasswordViewModel.getVerifionCodeCommand;
        // 设置当前按钮的状态
        RAC(self.getVerifitionCodeBtn, alpha) = [RACObserve(self.forgetPasswordViewModel, validUserName) map:^id(NSNumber *valid) {
            return [valid boolValue] ? @1 : @0.5;
        }];
        @weakify(self)
        __block NSUInteger times = 60;
        
        [[[[self.forgetPasswordViewModel.getVerifionCodeCommand.executionSignals doNext:^(id x) {
            @strongify(self)
            if (self.forgetPasswordViewModel.type){
                SEL sel = @selector(event:);
            [self MobClickPerform:sel withObject:kEventResetPawFirGetVoiceAuthcodeBtn];
//                [_MobClick event:kEventResetPawFirGetVoiceAuthcodeBtn];
            }
            else{
                SEL sel = @selector(event:);
            [self MobClickPerform:sel withObject:kEventResetPawFirGetAuthcodeBtn];
//                [_MobClick event:kEventResetPawFirGetAuthcodeBtn];
            [self resignAllTextFieldFirstResponder];
            }
        }] switchToLatest] filter:^BOOL(RkyForgetPasswordModel *model) {
            [CarlAlertView showAlertView:model.msg];
            return [model.status_code integerValue] == 200;
        }] subscribeNext:^(id x) {
            @strongify(self)
            // 点击后，60秒内不做任何动作，getVerifionCodeCommandExecuted为空信号
            self.getVerifitionCodeBtn.rac_command = self.forgetPasswordViewModel.getVerifionCodeCommandExecuted;
            // 60秒倒计时， 每秒执行一次，立即开始，执行60次，并在主线程上更改button的title
            [[[[[[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] startWith:[NSDate date]] take:60] takeUntil:self.disappearSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                @strongify(self)
                NSString *hintMsg = @"s重新获取验证码";
                if (self.forgetPasswordViewModel.type) {
                    hintMsg = @"s获取语音验证码";
                } else  {
                    hintMsg = @"s重新获取验证码";
                }
                [self.getVerifitionCodeBtn setTitle:[[@(times) stringValue] stringByAppendingString:hintMsg]
                                           forState:UIControlStateNormal];
                -- times;
            } completed:^{
                times = 60;
                if (self.forgetPasswordViewModel.type)
                    [self.getVerifitionCodeBtn setTitle:@"获取语音验证码" forState:UIControlStateNormal];
                else
                    [self.getVerifitionCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                // 还原原来的操作
                self.getVerifitionCodeBtn.rac_command = self.forgetPasswordViewModel.getVerifionCodeCommand;
            }];
        }];
        [self.forgetPasswordViewModel.getVerifionCodeCommand.errors subscribeNext:^(NSError *error) {
            // 网络发生错误
            [CarlAlertView showAlertView:error.domain];
        }];
    }
    return _getVerifitionCodeBtn;
}

- (UIButton *)verifiedBtn {
    if (!_verifiedBtn) {
        UIImage * imageLoginBtn = [UIImage bundleImage:@"loginQueren.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        _verifiedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifiedBtn setBackgroundImage: imageLoginBtn forState:UIControlStateNormal];
//        CGFloat top = (kScreenHeight == 480) ? self.passworldImageView.bottom + 16 : self.passworldImageView.bottom + 105;
//        _verifiedBtn.frame = CGRectMake(35, top, 500/2, 35);
        _verifiedBtn.frame = CGRECTMAKE(FORGETPASSWORD_VERIFIEDBTN_LEFT, FORGETPASSWORD_VERIFIEDBTN_TOP, FORGETPASSWORD_VERIFIEDBTN_WIDTH, FORGETPASSWORD_VERIFIEDBTN_HEIGHT);
        _verifiedBtn.centerX = self.containerView.width / 2;
        [_verifiedBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _verifiedBtn.alpha = 1;
        _verifiedBtn.rac_command = self.forgetPasswordViewModel.verifiedCommand;
        @weakify(self)
        [[[[self.forgetPasswordViewModel.verifiedCommand.executionSignals switchToLatest] doNext:^(RkyForgetPasswordModel *model) {
            @strongify(self)
            [self resignAllTextFieldFirstResponder];
            [CarlAlertView showAlertView:model.msg];
        }] filter:^BOOL(RkyForgetPasswordModel *model) {
            return [model.status_code integerValue] == 200;
        }] subscribeNext:^(id x) {
            @strongify(self)
            
            SEL sel = @selector(event:);
            [self MobClickPerform:sel withObject:kEventResetPawFirNextBtn];
//            [_MobClick event:kEventResetPawFirNextBtn];
            
            [self resignAllTextFieldFirstResponder];
            RkyResetPasswordViewModel *resetPasswordViewModel = [[RkyResetPasswordViewModel alloc] initWithViewModel:self.forgetPasswordViewModel];
            RkyResetPasswordViewController *resetPasswordViewController = [[RkyResetPasswordViewController alloc] init];
            resetPasswordViewController.resetPasswordViewModel = resetPasswordViewModel;
            [self.navigationController pushViewController:resetPasswordViewController animated:YES];
        }];
        [self.forgetPasswordViewModel.verifiedCommand.errors subscribeNext:^(NSError *error) {
            @strongify(self)
            [self resignAllTextFieldFirstResponder];
            [CarlAlertView showAlertView:error.domain];
        }];
    }
    return _verifiedBtn;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage bundleImage:@"loginBack.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] forState:UIControlStateNormal];
        _backButton.frame = CGRECTMAKE(FORGETPASSWORD_BACKBTN_LEFT, FORGETPASSWORD_BACKBTN_TOP, FORGETPASSWORD_BACKBTN_WIDTH, FORGETPASSWORD_BACKBTN_HEIGHT);
//        [_backButton sizeToFit];
//        _backButton.left = 15;
//        _backButton.top = 36;
        @weakify(self)
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            SEL sel = @selector(event:);
            [self MobClickPerform:sel withObject:kEventResetPawFirBackBtn];

//            [MobClick event:kEventResetPawFirBackBtn];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backButton;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage bundleImage:@"loginDitu.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
//        [_backgroundImageView sizeToFit];
        _backgroundImageView.frame = self.view.bounds;
        _backgroundImageView.left = 0;
        _backgroundImageView.top = 0;
    }
    return _backgroundImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage bundleImage:@"loginLogo.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [_logoImageView sizeToFit];
        _logoImageView.centerX = self.backgroundImageView.width / 2;
        _logoImageView.top = 100;
    }
    return _logoImageView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRECTMAKE(FORGETPASSWORD_CONTAINERVIEW_LEFT, FORGETPASSWORD_CONTAINERVIEW_TOP, FORGETPASSWORD_CONTAINERVIEW_WIDTH, FORGETPASSWORD_CONTAINERVIEW_HEIGHT)];
//        _containerView.width = self.view.width;
//        _containerView.height = self.verifiedBtn.bottom;
////        _containerView.top = self.view.height - _containerView.height - 80;
//        _containerView.top = 256;
//        _containerView.left = 0;
    }
    return _containerView;
}

- (RkyForgetPasswordViewModel *)forgetPasswordViewModel {
    if (!_forgetPasswordViewModel) {
        _forgetPasswordViewModel = [[RkyForgetPasswordViewModel alloc] init];
    }
    return _forgetPasswordViewModel;
}

- (void)resignAllTextFieldFirstResponder {
    [self.mailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)changeHeightWithKeyboradHeight:(CGFloat)height {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        if (height) {
            self.containerView.top = self.view.height - height - 25 - self.containerView.height;
        } else {
//            self.containerView.top = self.view.height - self.containerView.height - 80;
            self.containerView.top = 256;
        }
        
    } completion:nil];
}

- (void)showLogo:(BOOL)show {
    [UIView animateWithDuration:0.5 animations:^{
        self.logoImageView.alpha = show;
    }];
}

- (void)MobClickPerform:(SEL)sel withObject:(id)obj {
    if(self.MobClick && [self.MobClick respondsToSelector:sel]){
        [self.MobClick performSelector:sel withObject:obj];
    }
}

@end
