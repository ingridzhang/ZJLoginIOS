//
//  RkyResetPasswordViewController.m
//  EasyJieApp
//
//  Created by sun on 15/7/28.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "RkyResetPasswordViewController.h"
#import "RkyResetPasswordViewModel.h"
#import "ReactiveCocoa.h"
#import "RkyForgetPasswordModel.h"
#import "RkyLoginViewController.h"
#import "ASLoginViewFrameDefine.h"
#import "LoginHeader.h"

@interface RkyResetPasswordViewController ()

// 密码
@property (nonatomic, strong) UITextField *passwordTextField;

// 重置密码背景图片
@property (nonatomic, strong) UIImageView *passworldImageView;

// 确认按钮
@property (nonatomic, strong) UIButton *verifiedBtn;
// 返回上一页按钮
@property (nonatomic, strong) UIButton *backButton;
// 展示密码按钮
@property (nonatomic, strong) UIButton *showPasswordButton;

// 背景图片
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;

// 容器视图，用于包含输入框以及确认按钮，方便动画
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) RACSignal *disappearSignal;

@end

@implementation RkyResetPasswordViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.logoImageView];
    
    [self.containerView addSubview:self.passworldImageView];
    [self.passworldImageView addSubview:self.passwordTextField];
    [self.passworldImageView addSubview:self.showPasswordButton];
    [self.containerView addSubview:self.verifiedBtn];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.backButton];
    
    @weakify(self)
    // 点击背景键盘收回
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SEL sel = @selector(beginLogPageView:);
    [self MobClickPerform:sel withObject:NSStringFromClass([self class])];
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    SEL sel = @selector(endLogPageView:);
    [self MobClickPerform:sel withObject:NSStringFromClass([self class])];
//    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (UIImageView *)passworldImageView {
    if (!_passworldImageView) {
        _passworldImageView=[[UIImageView alloc]initWithFrame:CGRECTMAKE(RESETPASSWORD_PASSWORDIMAGEVIEW_LEFT, RESETPASSWORD_PASSWORDIMAGEVIEW_TOP, RESETPASSWORD_PASSWORDIMAGEVIEW_WIDTH, RESETPASSWORD_PASSWORDIMAGEVIEW_HEIGHT)];
        _passworldImageView.centerX = self.view.width / 2;
        _passworldImageView.userInteractionEnabled = YES;
        [_passworldImageView setImage:[UIImage bundleImage:@"loginMima.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
    }
    return _passworldImageView;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
//        _passwordTextField = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(self.passworldImageView.left+21.5, 0, 502/2-15-35, 47/2)];
        _passwordTextField = [[RkyCustomTextField alloc] initWithFrame:CGRECTMAKE(RESETPASSWORD_PASSWORDTEXTFIELD_LEFT, RESETPASSWORD_PASSWORDTEXTFIELD_TOP, RESETPASSWORD_PASSWORDTEXTFIELD_WIDTH, RESETPASSWORD_PASSWORDTEXTFIELD_HEIGHT)];
        _passwordTextField.centerY = self.passworldImageView.height / 2 - SCREEN_RADIO * 7;
        _passwordTextField.backgroundColor = [UIColor clearColor];
        _passwordTextField.placeholder = @"请输入6位以上新密码";
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordTextField setTextColor:[UIColor whiteColor]];
        _passwordTextField.text = @"";
        _passwordTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        [_passwordTextField setSecureTextEntry:YES]; //安全输入
        RAC(self.resetPasswordViewModel, password) = self.passwordTextField.rac_textSignal;
    }
    return _passwordTextField;
}


- (UIButton *)verifiedBtn {
    if (!_verifiedBtn) {
        UIImage * imageLoginBtn = [UIImage bundleImage:@"loginQueren.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        _verifiedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifiedBtn setBackgroundImage: imageLoginBtn forState:UIControlStateNormal];
//        _verifiedBtn.width = 250;
//        _verifiedBtn.height = 35;
//        _verifiedBtn.top = self.containerView.height - _verifiedBtn.height;
        _verifiedBtn.frame = CGRECTMAKE(RESETPASSWORD_VERIFIEDBTN_LEFT, RESETPASSWORD_VERIFIEDBTN_TOP, RESETPASSWORD_VERIFIEDBTN_WIDTH, RESETPASSWORD_VERIFIEDBTN_HEIGHT);
        _verifiedBtn.centerX = self.containerView.width / 2;
        [_verifiedBtn setTitle:@"确定" forState:UIControlStateNormal];
        _verifiedBtn.alpha = 1;
        _verifiedBtn.rac_command = self.resetPasswordViewModel.verifiedCommand;
        @weakify(self)
        [[[[self.resetPasswordViewModel.verifiedCommand.executionSignals switchToLatest] doNext:^(RkyForgetPasswordModel *model) {
            @strongify(self)
            SEL sel = @selector(event:);
            [self MobClickPerform:sel withObject:kEventResetPawSecSureBtn];
//            [MobClick event:kEventResetPawSecSureBtn];
            [self resignAllTextFieldFirstResponder];
             [CarlAlertView showAlertView:model.msg];
        }] filter:^BOOL(RkyForgetPasswordModel *model) {
            return [model.status_code integerValue] == 200;
        }] subscribeNext:^(id x) {
            @strongify(self)
            [self backToLoginPage];
        }];
        [self.resetPasswordViewModel.verifiedCommand.errors subscribeNext:^(NSError *error) {
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
        _backButton.frame = CGRECTMAKE(RESETPASSWORD_BACKBTN_LEFT, RESETPASSWORD_BACKBTN_TOP, RESETPASSWORD_BACKBTN_WIDTH, RESETPASSWORD_BACKBTN_HEIGHT);
//        [_backButton sizeToFit];
//        _backButton.left = 15;
//        _backButton.top = 36;
        @weakify(self)
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backButton;
}

- (UIButton *)showPasswordButton {
    if (!_showPasswordButton) {
        _showPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showPasswordButton setImage:[UIImage bundleImage:@"open_eye.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] forState:UIControlStateNormal];
//        [_showPasswordButton sizeToFit];
//        _showPasswordButton.centerY = self.passwordTextField.centerY;
//        _showPasswordButton.left = self.passwordTextField.right + 10;
        _showPasswordButton.frame = CGRECTMAKE(RESETPASSWORD_SHOWPASSWORDBTN_LEFT, RESETPASSWORD_SHOWPASSWORDBTN_TOP, RESETPASSWORD_SHOWPASSWORDBTN_WIDTH, RESETPASSWORD_SHOWPASSWORDBTN_HEIGHT);
        _showPasswordButton.centerY = self.passwordTextField.centerY;
        _showPasswordButton.rac_command = self.resetPasswordViewModel.showPasswordCommand;
        @weakify(self)
        [[[_showPasswordButton.rac_command.executionSignals map:^id(id value) {
            @strongify(self)
            SEL sel = @selector(event:);
            [self MobClickPerform:sel withObject:kEventResetPawSecShowPawBtn];
//            [MobClick event:kEventResetPawSecShowPawBtn];
            self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
            return @(self.passwordTextField.secureTextEntry);
        }] map:^(NSNumber *secure) {
            return [secure boolValue] ? [UIImage bundleImage:@"open_eye.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] : [UIImage bundleImage:@"close_eye.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        }] subscribeNext:^(UIImage *image) {
            @strongify(self)
            [self.showPasswordButton setImage:image forState:UIControlStateNormal];
        }];
    }
    return _showPasswordButton;
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
        _containerView = [[UIView alloc] initWithFrame:CGRECTMAKE(RESETPASSWORD_CONTAINERVIEW_LEFT, RESETPASSWORD_CONTAINERVIEW_TOP, RESETPASSWORD_CONTAINERVIEW_WIDTH, RESETPASSWORD_CONTAINERVIEW_HEIGHT)];
        _containerView.backgroundColor = [UIColor redColor];
//        _containerView.width = self.view.width;
//        _containerView.height = (kScreenHeight == 480) ? 80 : 170;
////        _containerView.top = self.view.height - _containerView.height - 80;
//        _containerView.top = 256;
//        _containerView.left = 0;
    }
    return _containerView;
}

- (void)resignAllTextFieldFirstResponder {
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

// 返回登录页
- (void)backToLoginPage {
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[RkyLoginViewController class]]) {
            *stop = YES;
            [self.navigationController popToViewController:obj animated:YES];
        }
    }];
}

- (void)MobClickPerform:(SEL)sel withObject:(id)obj {
    if(self.MobClick && [self.MobClick respondsToSelector:sel]){
        [self.MobClick performSelector:sel withObject:obj];
    }
}

@end
