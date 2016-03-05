//
//  RkyLoginView.m
//  EasyJie
//
//  Created by ricky on 14-8-24.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#define kNextViewPoint_y(view)(view.frame.size.height+view.frame.origin.y)

#import "RkyLoginView.h"
#import "RkyLoginDefine.h"
#import "ReactiveCocoa.h"
#import "UIImage+Extension.h"
#import "LoginHeader.h"

@interface RkyLoginView () <UITextFieldDelegate>
@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, strong) RkyCustomTextField *  mailTextField;
@property (nonatomic, strong) RkyCustomTextField *  passwordTextField;
@property (nonatomic, assign) CGFloat heightOffset;
@property (nonatomic, assign) BOOL isInputing;
@end

@implementation RkyLoginView
{
    UIButton * forgotBtn;
    UIButton * loginBtn;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImageView *emailImageView=[[UIImageView alloc]initWithFrame:CGRectMake(35, 7, 502/2, 47/2)];
        emailImageView.centerX = self.width / 2;
        [emailImageView setImage:[UIImage bundleImage:@"loginYouXiang.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [self addSubview:emailImageView];
        
        RkyCustomTextField * mailTextField = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(emailImageView.left + 21.5, 0, 502/2-15, 47/2)];
        mailTextField.delegate = self;
        mailTextField.placeholder = @"请输入手机号/邮箱号";
        mailTextField.backgroundColor = [UIColor clearColor];
        mailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        mailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        mailTextField.textColor=[UIColor whiteColor];
        mailTextField.text = @"";
        mailTextField.font =[UIFont boldSystemFontOfSize:16];
        mailTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    
        [mailTextField addTarget:self action:@selector(onMailTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [mailTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:mailTextField];
        self.mailTextField = mailTextField;

        
        UIImageView *passworldImageView=[[UIImageView alloc]initWithFrame:CGRectMake(emailImageView.left, emailImageView.bottom+31, 502/2, 47/2)];
        [passworldImageView setImage:[UIImage bundleImage:@"loginMima.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [self addSubview:passworldImageView];
        
        RkyCustomTextField * passwordTextField = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(passworldImageView.left+21.5, kNextViewPoint_y(emailImageView)+24, mailTextField.width-66, 47/2)];
        passwordTextField.delegate = self;
        passwordTextField.backgroundColor = [UIColor clearColor];
        passwordTextField.placeholder = @"请输入密码";
        passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [passwordTextField setTextColor:[UIColor whiteColor]];
        passwordTextField.text = @"";
        passwordTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        [passwordTextField setSecureTextEntry:YES]; //安全输入
        
        [passwordTextField addTarget:self action:@selector(onPasswordTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:passwordTextField];
        self.passwordTextField = passwordTextField;
        
        forgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forgotBtn.frame = CGRectMake(35+21.5, kNextViewPoint_y(emailImageView)+24, 61, 23);
        
        [forgotBtn setBackgroundImage:[[UIImage bundleImage:@"btn_Image.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
        
        [forgotBtn setTitle:@"找回密码" forState:UIControlStateNormal];
        [self addSubview:forgotBtn];
        [forgotBtn setTitleColor:[UIColor colorWithHexString:@"#FFB200"] forState:UIControlStateNormal];
        forgotBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        forgotBtn.right = passworldImageView.right;
        forgotBtn.bottom = passworldImageView.bottom-6;
        @weakify(self)
        [[forgotBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self didTouchMaskView];
            if ([self.delegate respondsToSelector:@selector(forgetPassword:)]) {
                [self.delegate forgetPassword:self];
            }
        }];
        
        
        UIImage * imageLoginBtn = [UIImage bundleImage:@"loginQueren.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setBackgroundImage: imageLoginBtn forState:UIControlStateNormal];
        CGFloat top = (kScreenHeight == 480) ? passworldImageView.bottom + 16 : passworldImageView.bottom + 105;
        loginBtn.frame = CGRectMake(emailImageView.left, top ,500/2, 35);
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginBtn];
        loginBtn.enabled = NO;
        loginBtn.alpha = 0.5;
        
        if ([WXApi isWXAppInstalled]) {
            UIButton * weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [weixinBtn setFrame:CGRectMake(35, kNextViewPoint_y(loginBtn)+kPointValue(30), kPointValue(96), kPointValue(30))];
            [weixinBtn setTitle:NSLocalizedString(@"微信登录", nil) forState:UIControlStateNormal];
            [weixinBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [weixinBtn sizeToFit];
            [self addSubview:weixinBtn];
            weixinBtn.bottom = self.height -25;
            
            [weixinBtn addTarget:self action:@selector(onWeixinLogin:) forControlEvents:UIControlEventTouchUpInside];
        
            UIImageView * underLine1 = [[UIImageView alloc] initWithImage:[UIImage bundleImage:@"login-line1.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
            [underLine1 setFrame:CGRectMake(10, kNextViewPoint_y(weixinBtn)-kPointValue(10), kPointValue(96), kPointValue(1))];
            [self addSubview:underLine1];
            underLine1.left = weixinBtn.left;
        }

        UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [registerBtn setFrame:CGRectMake(kPointValue(500), kNextViewPoint_y(loginBtn)+kPointValue(30),kPointValue(120), kPointValue(30))];
        [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [registerBtn sizeToFit];
        [self addSubview:registerBtn];
        [registerBtn addTarget:self action:@selector(onRegister:) forControlEvents:UIControlEventTouchUpInside];
        registerBtn.right = self.width-35;
        registerBtn.bottom = self.height -25;
        
        
        UIImageView * underLine2 = [[UIImageView alloc] initWithImage:[UIImage bundleImage:@"login-line2.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [underLine2 setFrame:CGRectMake(kPointValue(500),  kNextViewPoint_y(registerBtn)-kPointValue(10), kPointValue(120), kPointValue(1))];
        [self addSubview:underLine2];
        underLine2.right = registerBtn.right;
        
        // 注册键盘变化通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    return self;
}


#pragma mark - UIKeyboardNotification methods

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if (self.isInputing) {
        return;
    }
    self.isInputing = YES;
    if (self.maskView.superview == nil) {
        [self.superview insertSubview:self.maskView belowSubview:self];
    }
    [self.delegate hideLogoImageAlpha:NO];
    self.maskView.hidden = NO;
    self.heightOffset = 50;//passwordFrame.origin.y + passwordFrame.size.height - keyboardFrame.origin.y;

    if (self.heightOffset > 0) {
        if ([self.delegate respondsToSelector:@selector(loginViewHeightChange:withOffset:)]) {
            [self.delegate loginViewHeightChange:self withOffset:-self.heightOffset-135];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    if (!self.isInputing) {
        return;
    }
    self.isInputing = NO;
    [self.delegate hideLogoImageAlpha:YES];
    self.maskView.hidden = YES;
    if (self.heightOffset > 0) {
        if ([self.delegate respondsToSelector:@selector(loginViewHeightChange:withOffset:)]) {
            [self.delegate loginViewHeightChange:self withOffset:self.heightOffset+135];
        }
    }
}

#pragma mark - getter & setter
- (UIControl *)maskView
{
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_maskView addTarget:self action:@selector(didTouchMaskView) forControlEvents:UIControlEventTouchDown];
        _maskView.backgroundColor = [UIColor clearColor];
    }
    return _maskView;
}


#pragma mark - control event

- (void)didTouchMaskView
{
    self.maskView.hidden = YES;
    [self.mailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void) onMailTextField:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }

    [self.passwordTextField becomeFirstResponder];

}

- (void) onPasswordTextField:(UITextField *) textField
{
    [self didTouchMaskView];
}

- (void) onLogin: (UIButton *) button
{
    [self didTouchMaskView];
    
    self.isMobelNum = NO;
    if ([self checkTel:self.mailTextField.text])
    {
        self.isMobelNum = YES;
    }
    if ([self.delegate respondsToSelector:@selector(mailLoginHandler:)]) {
        [self.delegate mailLoginHandler:self];
        
    }
    else
    {
        [CarlAlertView showAlertView:@"用户名或密码错误"];
    }
}

- (BOOL)checkTel:(NSString *)str

{
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = @"^[1][3,5,7,8]+\\d{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}
//邮箱格式检测
- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"\\w+@\\w+\\.[a-z]+(\\.[a-z]+)?";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}



- (void) onWeixinLogin:(UIButton *) button
{
    if ([self.delegate respondsToSelector:@selector(weixinLoginHandler:)]) {
        [self.delegate weixinLoginHandler:self];
    }
}

- (void) onRegister:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(registerHandler:)]) {
        [self.delegate registerHandler:self];
    }
}


- (void) textFieldDidChange:(UITextField *) TextField
{
    if (_mailTextField.text.length>=1 && _passwordTextField.text.length >= 6) {
        loginBtn.enabled = YES;
        loginBtn.alpha = 1;
    } else {
        loginBtn.alpha = 0.5;
        loginBtn.enabled = NO;
    }
}

- (BOOL)validUserName:(NSString *)userName {
    return [self validEmail:userName] || [self validPhoneNumber:userName];
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

@end
