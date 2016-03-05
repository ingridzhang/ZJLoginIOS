//
//  RkyNameView.m
//  EasyJieApp
//
//  Created by 李世乾 on 15/7/23.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//
#define kNextViewPoint_y(view)(view.frame.size.height+view.frame.origin.y)
#import "RkyNameView.h"
#import "RkyLoginDefine.h"
#import "ReactiveCocoa.h"
#import "RkyAgreementView.h"
#import "RkyLoginService.h"
#import "UIImage+Extension.h"
#import "LoginHeader.h"

@interface RkyNameView () <UITextFieldDelegate>
@property (nonatomic, strong, readwrite) RkyCustomTextField * nickNameInput;
@property (nonatomic, strong, readwrite) RkyCustomTextField * passwordInput;
@property (nonatomic, strong) UIButton * commitBtn;
@property (nonatomic, strong) UIButton *yanzmBtn ;
@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, assign) BOOL isInputing;
@property (nonatomic, assign) CGFloat heightOffset;

@end
@implementation RkyNameView
{
    BOOL buttonStatus;
    BOOL eyeBool;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *userNameImageView=[[UIImageView alloc]initWithFrame:CGRectMake(35, 7, 502/2, 47/2)];
        userNameImageView.centerX = self.width / 2;
        [userNameImageView setImage:[UIImage bundleImage:@"loginZhanghao.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [self addSubview:userNameImageView];
        
        self.nickNameInput = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(userNameImageView.left+21.5, 0, 502/2-15, 47/2)];
        self.nickNameInput.placeholder = @"请输入昵称（6-20个字符）";
        self.nickNameInput.textColor=[UIColor whiteColor];
        UILabel * nickNameLabel = [[UILabel alloc] init];
        nickNameLabel.text = @"昵称";
        [self.nickNameInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.nickNameInput addTarget:self action:@selector(onNickNameInputEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:self.nickNameInput];

        
        UIImageView *emailImageView=[[UIImageView alloc]initWithFrame:CGRectMake(userNameImageView.left, kNextViewPoint_y(userNameImageView)+31, 502/2, 47/2)];
        [emailImageView setImage:[UIImage bundleImage:@"loginMima.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [self addSubview:emailImageView];
        
        self.passwordInput = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(emailImageView.left+21.5, kNextViewPoint_y(userNameImageView)+24, emailImageView.width-21.5-30, 47/2)];
        self.passwordInput.delegate = self;
        self.passwordInput.backgroundColor = [UIColor clearColor];
        self.passwordInput.placeholder = @"请输入密码";
        self.passwordInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.passwordInput setTextColor:[UIColor whiteColor]];
        self.passwordInput.text = @"";
        self.passwordInput.autocorrectionType = UITextAutocorrectionTypeYes;
        [self.passwordInput setSecureTextEntry:YES]; //安全输入
        [self.passwordInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.passwordInput];

        
        eyeBool = NO;//闭眼
        UIButton * eyeButton = [UIButton buttonWithType:0];
        eyeButton.frame = CGRectMake(235, kNextViewPoint_y(self.passwordInput), 15, 14);
        UIImage *image = [UIImage bundleImage:@"open_eye.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        [eyeButton setImage:image forState:UIControlStateNormal];
        [eyeButton addTarget:self action:@selector(changeEyeStatus:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:eyeButton];
        eyeButton.centerY =self.passwordInput.centerY;
        eyeButton.right =emailImageView.right-10;
        
        
        
        
        
        
        UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * commitImage = [UIImage bundleImage:@"loginQueren.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        [commitBtn setBackgroundImage:commitImage forState:UIControlStateNormal];
        [commitBtn setTitle:@"注册" forState:UIControlStateNormal];
        //RykInitialButtonForKey(commitBtn, kLoginModule, kRegisterText);
        //[commitBtn sizeToFit];
        commitBtn.frame = CGRectMake(35, emailImageView.bottom+kPointValue(80),500/2, 35);
        commitBtn.centerX = self.width / 2;
        [self addSubview:commitBtn];
        [commitBtn addTarget:self action:@selector(CommitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.commitBtn = commitBtn;
        commitBtn.bottom = self.height-80;
        
        self.commitBtn.alpha = 0.5;
        self.commitBtn.userInteractionEnabled = NO;
        
        
        
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, 300, 100)];
        label.backgroundColor = [UIColor clearColor];
        label.font =[UIFont systemFontOfSize:12];
        label.textColor =  [UIColor colorWithHexString:@"#EEEEEE"];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"阅读并接受用户协议"]];
        NSRange contentRange = {5,4};
        [content setAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#ffb200"],NSFontAttributeName :label.font}range:contentRange];
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        label.attributedText = content;
        [self addSubview:label];
        CGRect rect = [@"阅读并接受用户协议" boundingRectWithSize:
                       CGSizeMake(label.width, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil];
        
        label.height = rect.size.height;
        label.width = rect.size.width;
        label.bottom = self.height-25;
        label.centerX = commitBtn.centerX;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        [label addGestureRecognizer:tapGesture];
        @weakify(self)
        [[[tapGesture rac_gestureSignal] flattenMap:^RACStream *(id value) {
            @strongify(self)
//            [MobClick event:kEventRegisterSecUserAgreementBtn];
            label.userInteractionEnabled = NO;
            return [self requestAgreement];
        }] subscribeNext:^(NSString *content) {
            @strongify(self)
            RkyAgreementView *agreementView = [[RkyAgreementView alloc] initWithFrame:CGRectMake(0, 0, self.superview.width, self.superview.height)];
            agreementView.content = content;
            [self.superview addSubview:agreementView];
            label.userInteractionEnabled = YES;
        }];
        
        UIImageView *chooseImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
        chooseImage.image =[UIImage bundleImage:@"choose_Y.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        [self addSubview:chooseImage];
        chooseImage.tag = 1910;
        chooseImage.right = label.left-4;
        chooseImage.centerY = label.centerY;
        
        buttonStatus = YES;
        UIButton *chooseButton =[UIButton buttonWithType:0];
        chooseButton.frame = CGRectMake(10, 100, 30, 30);
        [chooseButton addTarget:self action:@selector(changChooseStatus) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseButton];
        chooseButton.center =chooseImage.center;
        chooseButton.right =chooseImage.right;
        
//        UIButton *userPro =[UIButton buttonWithType:0];
//        userPro.frame = CGRectMake(10, 100, label.width, 30);
//        [userPro addTarget:self action:@selector(lookUserProtocol) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:userPro];
//        userPro.center =chooseImage.center;
//        userPro.left =label.left;
        
        
        
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
-(void)changeEyeStatus:(UIButton *)sender
{
//    [MobClick event:kEventRegisterSecShowPawBtn];
    if(!eyeBool)
    {
        UIImage *image = [UIImage bundleImage:@"close_eye.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        [sender setImage:image forState:UIControlStateNormal];
        [self.passwordInput setSecureTextEntry:NO];
    }else
    {
        UIImage *image = [UIImage bundleImage:@"open_eye.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        [sender setImage:image forState:UIControlStateNormal];
        [self.passwordInput setSecureTextEntry:YES];
    }
    eyeBool = !eyeBool;
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
    
    self.maskView.hidden = NO;
    [self.delegate hideLogoImageAlpha:NO];
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect inputFrame = self.frame;
    self.heightOffset = inputFrame.origin.y + inputFrame.size.height - keyboardFrame.origin.y;
    self.heightOffset = 50;
    if (self.heightOffset > 0) {
        if ([self.delegate respondsToSelector:@selector(registerInputViewHeightChange:withOffset:)]) {
            [self.delegate registerInputViewHeightChange:self withOffset:-self.heightOffset-125];
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
        if ([self.delegate respondsToSelector:@selector(registerInputViewHeightChange:withOffset:)]) {
            [self.delegate registerInputViewHeightChange:self withOffset:self.heightOffset+125];
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
    [self.nickNameInput resignFirstResponder];
    [self.passwordInput resignFirstResponder];
}

- (void)CommitBtnClicked:(UIButton *) button
{
//    [MobClick event:kEventRegisterSecUserRegisterBtn];
    [self didTouchMaskView];
    if ([self.delegate respondsToSelector:@selector(registerInputViewCommit:)]) {
        [self.delegate registerInputViewCommit:self];
    }
}

//- (void) onNickNameInput:(UITextField *) textField
//{
//    if (textField.text.length == 0) {
//        [textField becomeFirstResponder];
//        return;
//    }
//    if (self.nickNameInput.text.length && self.nickNameInput.text.length && self.passwordInput.text.length) {
//        self.commitBtn.enabled = YES;
//    }
//}


- (void) onPasswordInput:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    
    if (self.nickNameInput.text.length && self.nickNameInput.text.length && self.passwordInput.text.length) {
        
        self.commitBtn.enabled = YES;
    }
    
}


- (void) onNickNameInputEnd:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    [self.nickNameInput becomeFirstResponder];
}

- (void) onMailInputEnd:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    [self.passwordInput becomeFirstResponder];
}

- (void) onPasswordInputEnd:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    
//    if ([self.delegate respondsToSelector:@selector(registerInputViewCommit:)]) {
//        [self.delegate registerInputViewCommit:self];
//    }
}

- (UIView *)getRegisterViewWithImageName:(NSString *)imageName title:(NSString *)title
{
    UIView *imageView = [[UIView alloc] init];
    [imageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage bundleImage:imageName bundleClass:[self class] bundleName:@"EasyLoginIOS"]]];
    imageView.frame = CGRectMake(0, 0, 300, 40);
    imageView.userInteractionEnabled = YES;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 200, 40)];
    textField.placeholder = title;
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [imageView addSubview:textField];
    
    return imageView;
}
- (void) textFieldDidChange:(UITextField *) TextField
{
    if ([self isValidName] && _passwordInput.text.length>=6 && buttonStatus) {
        self.yanzmBtn.alpha = 1;
        self.commitBtn.alpha = 1;
        self.yanzmBtn.userInteractionEnabled = YES;
        self.commitBtn.userInteractionEnabled = YES;
    }else
    {
        self.yanzmBtn.alpha = 0.5;
        self.commitBtn.alpha = 0.5;
        self.yanzmBtn.userInteractionEnabled = NO;
        self.commitBtn.userInteractionEnabled = NO;
    }
}
-(BOOL)isValidName
{
    NSInteger length = _nickNameInput.text.length;
    
    if (length<3||length>20)
    {
        return NO;
    }else
    {
        return YES;
    }
    
    
    return NO;
}
#pragma check button status
-(void)changChooseStatus
{
    UIImageView *imgae = (UIImageView*)[self viewWithTag:1910];
    if (buttonStatus)
    {
        imgae.image =[UIImage bundleImage:@"choose_N.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
    }else
    {
        imgae.image =[UIImage bundleImage:@"choose_Y.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
    }
    buttonStatus = !buttonStatus;
}
//显示用户协议
-(void)lookUserProtocol
{
    ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - requestAgreement
- (RACSignal *)requestAgreement {
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [RkyLoginService getAgreementSuccess:^(NSString *content) {
            [subscriber sendNext:content];
            [subscriber sendCompleted];
        } failure:^{
            NSError *error = [[NSError alloc] initWithDomain:@"网络异常，请稍后重试" code:0 userInfo:nil];
            [subscriber sendError:error];
        }];
        
        return nil;
    }] publish] autoconnect];
}

@end
