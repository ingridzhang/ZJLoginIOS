
#import "RkyRegisterInputView.h"
#import "RkyLoginDefine.h"
#import "RkyForgetPasswordModel.h"
#import "ReactiveCocoa.h"
#import "RkyAgreementView.h"
#import "RkyLoginService.h"
#import "LoginHeader.h"

@interface RkyRegisterInputView () <UITextFieldDelegate>
@property (nonatomic, strong, readwrite) RkyCustomTextField * nickNameInput;
@property (nonatomic, strong, readwrite) RkyCustomTextField * emailInput;
@property (nonatomic, strong, readwrite) RkyCustomTextField * passwordInput;
@property (nonatomic, strong) UIButton * commitBtn;
@property (nonatomic, strong) UIButton *yanzmBtn ;
@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, assign) BOOL isInputing;
@property (nonatomic, assign) CGFloat heightOffset;

@end
@implementation RkyRegisterInputView
{
    BOOL buttonStatus;
    BOOL isYuyinYz;
}
- (void)dealloc
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
        
        self.emailInput = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(emailImageView.left+21.5, 0, 502/2-15, 47/2)];
        self.emailInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.emailInput.placeholder = @"请输入手机号";
        self.emailInput.keyboardType = UIKeyboardTypePhonePad;
        self.emailInput.textColor=[UIColor whiteColor];
        [self.emailInput addTarget:self action:@selector(onMailInput:) forControlEvents:UIControlEventEditingChanged];
        [self.emailInput addTarget:self action:@selector(onMailInputEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:self.emailInput];
        [self.emailInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIImageView *passwordImageView=[[UIImageView alloc]initWithFrame:CGRectMake(emailImageView.left, emailImageView.bottom+31, 502/2, 47/2)];
        [passwordImageView setImage:[UIImage bundleImage:@"loginYanzhengma.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];
        [self addSubview:passwordImageView];
        
        self.passwordInput = [[RkyCustomTextField alloc] initWithFrame:CGRectMake(passwordImageView.left+21.5, emailImageView.bottom+24, passwordImageView.right - 120 - 10 - 56.5, 47/2)];
        self.passwordInput.textColor=[UIColor whiteColor];
        self.passwordInput.placeholder = @"请输入验证码";
        self.passwordInput.keyboardType = UIKeyboardTypeNumberPad;
        [self.passwordInput addTarget:self action:@selector(onPasswordInput:) forControlEvents:UIControlEventEditingChanged];
        [self.passwordInput addTarget:self action:@selector(onPasswordInputEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.passwordInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.passwordInput];
        
        isYuyinYz = NO;
        self.yanzmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.yanzmBtn.frame = CGRectMake(passwordImageView.left+21.5, emailImageView.bottom+24, 120, 23);
        self.yanzmBtn.centerY = self.passwordInput.centerY;
        [self.yanzmBtn setBackgroundImage:[[UIImage bundleImage:@"btn_Image.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] stretchableImageWithLeftCapWidth:15 topCapHeight:0] forState:UIControlStateNormal];
        [self.yanzmBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self addSubview:self.yanzmBtn];
        [self.yanzmBtn setTitleColor:[UIColor colorWithHexString:@"#FFB200"] forState:UIControlStateNormal];
        self.yanzmBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        self.yanzmBtn.right = passwordImageView.right;
        self.yanzmBtn.userInteractionEnabled = NO;
        self.yanzmBtn.alpha = 0.5;
        [self.yanzmBtn addTarget:self action:@selector(sendMassageOftype) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * commitImage = [UIImage bundleImage:@"loginQueren.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
        [commitBtn setBackgroundImage:commitImage forState:UIControlStateNormal];
        [commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        //RykInitialButtonForKey(commitBtn, kLoginModule, kRegisterText);
        //[commitBtn sizeToFit];
        CGFloat top = (kScreenHeight == 480) ? passwordImageView.bottom + 16 : passwordImageView.bottom + 105;
        commitBtn.frame = CGRectMake(passwordImageView.left, top,500/2, 35);
        [self addSubview:commitBtn];
        [commitBtn addTarget:self action:@selector(CommitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        commitBtn.enabled = NO;
        self.commitBtn = commitBtn;
//        commitBtn.bottom = self.height-80;
        
        self.commitBtn.alpha = 0.5;
        self.commitBtn.userInteractionEnabled = NO;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, 300, 100)];
        label.backgroundColor = [UIColor clearColor];
        label.font =[UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithHexString:@"#EEEEEE"];
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
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [label addGestureRecognizer:tapGesture];
        @weakify(self)
        [[[tapGesture rac_gestureSignal] flattenMap:^RACStream *(id value) {
            @strongify(self)
//            [MobClick event:kEventRegisterFirUserAgreementBtn];
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
        [chooseButton addTarget:self action:@selector(changeButtonChooseOfUserProStatus) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseButton];
        chooseButton.center =chooseImage.center;
        chooseButton.right =chooseImage.right;
        
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
    [self.emailInput resignFirstResponder];
    [self.passwordInput resignFirstResponder];
}

- (void)CommitBtnClicked:(UIButton *) button
{
//    [MobClick event:kEventRegisterFirUserNextBtn];
    [self didTouchMaskView];
    
    [RkyLoginService checkSMSCode:@{@"mobile":self.emailInput.text, @"verify_code":self.passwordInput.text} success:^(RkyForgetPasswordModel *model) {
        if ([model.status_code integerValue] == 200) {
            if ([self.delegate respondsToSelector:@selector(registerInputViewCommit:)]) {
                [self.delegate registerInputViewCommit:self];
            }
        } else {
            [CarlAlertView showAlertView:model.msg];
        }
    } failure:^{
        [CarlAlertView showAlertView:@"网络异常，请稍后重试"];
    }];
}

- (void) onNickNameInput:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    if (self.nickNameInput.text.length && self.emailInput.text.length && self.passwordInput.text.length) {
        self.commitBtn.enabled = YES;
    }
}

- (void) onMailInput:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
}

//邮箱格式检测
- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (void) onPasswordInput:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    
    if (self.nickNameInput.text.length && self.emailInput.text.length && self.passwordInput.text.length) {
        self.commitBtn.enabled = YES;
    }
}

- (void) onNickNameInputEnd:(UITextField *) textField
{
    if (textField.text.length == 0) {
        [textField becomeFirstResponder];
        return;
    }
    [self.emailInput becomeFirstResponder];
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
- (void) textFieldDidChange:(RkyCustomTextField *) TextField
{
    [self changBtuttonStatus];
}
-(void)changBtuttonStatus
{
    if (_emailInput.text.length>0) {
        
        if (_emailInput.text.length>=11)
        {
            self.yanzmBtn.alpha = 1;
            self.yanzmBtn.userInteractionEnabled = YES;
            if (![self validPhoneNumber:_emailInput.text])
            {
                _emailInput.text = [_emailInput.text substringWithRange:NSMakeRange(0, 11)];
            }
        } else {
            self.yanzmBtn.alpha = 0.5;
            self.yanzmBtn.userInteractionEnabled = NO;
        }
        if (_passwordInput.text.length>6)
        {
            //        [CarlAlertView showAlertView:@"请确定验证码"];
            _passwordInput.text = [_passwordInput.text substringWithRange:NSMakeRange(0, 6)];
        }
        if ([self validPhoneNumber:_emailInput.text] && _passwordInput.text.length>=6) {
            self.yanzmBtn.alpha = 1;
            self.commitBtn.alpha = 1;
            self.yanzmBtn.userInteractionEnabled = YES;
            self.commitBtn.userInteractionEnabled = YES;
        } else {
            self.commitBtn.alpha = 0.5;
            self.commitBtn.userInteractionEnabled = NO;
        }
    }else
    {
        self.yanzmBtn.alpha = 0.5;
        self.commitBtn.alpha = 0.5;
        self.yanzmBtn.userInteractionEnabled = NO;
        self.commitBtn.userInteractionEnabled = NO;
    }
    if (!buttonStatus || _passwordInput.text.length!=6) {
        self.commitBtn.alpha = 0.5;
        self.commitBtn.userInteractionEnabled = NO;
    }
    
}
-(void)runTimer
{
    if(![self validPhoneNumber:_emailInput.text])
    {
        [CarlAlertView showAlertView:@"请输入有效手机号！"];
        return ;
    }
    self.yanzmBtn.width = 120;
    self.yanzmBtn.right = [UIScreen mainScreen].bounds.size.width-35;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
//            dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.yanzmBtn.width = 120;
                self.yanzmBtn.alpha = 1;
                [self.yanzmBtn setTitle:@"获取语音验证码" forState:UIControlStateNormal];
                self.yanzmBtn.right = [UIScreen mainScreen].bounds.size.width-35;
                self.yanzmBtn.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.yanzmBtn setTitle:[NSString stringWithFormat:@"%ds获取语音验证码",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }  
    });
    self.theTimer = _timer;
    dispatch_resume(_timer);
}
#pragma check button status
-(void)changeButtonChooseOfUserProStatus
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
    [self changBtuttonStatus];
}
//显示用户协议
-(void)lookUserProtocol
{
    ;
}



//检测手机号码
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
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}

// 验证手机号是否是11位数字
- (BOOL)validPhoneNumber:(NSString *)phoneNum {
    NSString *phoneNumRegex = @"^\\d{11}$";
    NSPredicate *phoneNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumRegex];
    return [phoneNumTest evaluateWithObject:phoneNum];
}

-(BOOL)isValidCode:(NSString *)str
{
    if (str.length != 6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
    return NO;
}


-(void)sendMassageOftype
{
//    [MobClick event:kEventRegisterFirGetAuthcodeBtn];
    [self didTouchMaskView];
    self.yanzmBtn.enabled = NO;
    
    [RkyLoginService sendSMSCode:@{@"mobile":self.emailInput.text, @"type":[@(isYuyinYz) stringValue]} success:^(RkyForgetPasswordModel *model) {
        isYuyinYz = YES;
        [CarlAlertView showAlertView:model.msg];
        if ([model.status_code integerValue] == 200) {
            [self runTimer];
        } else {
            self.yanzmBtn.enabled = YES;
        }
    } failure:^{
        isYuyinYz = YES;
        self.yanzmBtn.enabled = YES;
    }];
}

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

-(void)updateTimer
{
    isYuyinYz = YES;
    self.yanzmBtn.width = 120;
    self.yanzmBtn.alpha = 1;
    [self.yanzmBtn setTitle:@"获取语音验证码" forState:UIControlStateNormal];
    self.yanzmBtn.right = [UIScreen mainScreen].bounds.size.width-35;
    self.yanzmBtn.enabled = YES;
}

@end
