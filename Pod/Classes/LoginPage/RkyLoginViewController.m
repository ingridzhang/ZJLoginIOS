//
//  RkyLoginViewController.m
//  EasyJie
//
//  Created by ricky on 14-8-26.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//
#define kPointY(a)(a/1136*[[UIScreen mainScreen]bounds].size.height)
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#import "Masonry.h"
#import "RkyLoginViewController.h"
#import "RkyLoginDefine.h"
#import "RkyLoginView.h"
#import "RkyWeixinHandler.h"
#import "RkyLoginPageRegisterViewController.h"
#import "RkyForgetPasswordViewController.h"
#import "ReactiveCocoa.h"
#import "EZApp.h"
#import "RkyLoginService.h"
#import "RkyMailHandler.h"
#import "UIImage+Extension.h"
#import "LoginHeader.h"

@interface RkyLoginViewController ()<RkyLoginViewDelegate>

@end

@implementation RkyLoginViewController
{
    UIImageView * logoImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SEL sel = @selector(beginLogPageView:);
    [self MobClickPerform:sel withObject:kLoginPage];
    
//    [MobClick beginLogPageView:kLoginPage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    SEL sel = @selector(endLogPageView:);
    [self MobClickPerform:sel withObject:kLoginPage];
    
//    [MobClick endLogPageView:kLoginPage];
}




#pragma mark - init ui

- (void) initUI
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self buildBackgroundView];
    [self buildLoginView];
    [self buildBackButton];
}

- (void) buildBackgroundView
{
    UIImage * bgImage = [UIImage bundleImage:@"loginDitu.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
//    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:bgImage];
//    [bgImageView sizeToFit];
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:bgImage];
    
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
    
    logoImageView = [[UIImageView alloc] initWithImage:[UIImage bundleImage:@"loginLogo.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"]];//hp-logo
//    [logoImageView sizeToFit];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
//    logoImageView.centerX = self.view.width * 0.5;
//    logoImageView.top = 100;
   
}

- (void) buildBackButton
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage bundleImage:@"loginBack.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(36);
    }];
}

- (void) buildLoginView
{
    float oringY = 265;
    if ([UIScreen mainScreen].bounds.size.height>=1136)
    {
        oringY  = 314;
    }
    
    RkyLoginView * loginView = [[RkyLoginView alloc] initWithFrame: CGRectMake(0, oringY, self.view.width,self.view.height-oringY)];//kLoginViewHeight 170
    [loginView setTag:10111];
    loginView.delegate = self;
//    loginView.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [loginView didTouchMaskView];
    }];
    
    [self.view addSubview:loginView];
}

#pragma mark - control clicked
- (void) backBtnClicked:(UIButton *) button
{
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:kEventLoginBackBtn];
    
//    [MobClick event:kEventLoginBackBtn];
    if (self.cancelLogin) {
        self.cancelLogin();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - loginview delegate
- (void) loginViewHeightChange: (RkyLoginView *) loginView withOffset:(CGFloat) offset
{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        loginView.frame = CGRectOffset(loginView.frame, 0, offset);

    } completion:nil];
}
-(void)hideLogoImageAlpha:(BOOL)alphaYN
{
    
    [UIView animateWithDuration:0.5 animations:^{
        logoImageView.alpha = alphaYN;
    }];
}
#pragma mark Login
- (void) mailLoginHandler: (RkyLoginView *) loginView
{
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:kEventLoginUserLoginBtn];
//    [MobClick event:kEventLoginUserLoginBtn];
    NSString *emailTxt = loginView.mailTextField.text;
    NSString *mobeiTxt = loginView.mailTextField.text;
    NSString *password = [loginView.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    void(^loginSuccess)(RkyUser *user) = ^(RkyUser *user) {
        if (self.cancelLogin) {
            self.cancelLogin();
        }
        SEL sel = @selector(profileSignInWithPUID:);
        [self MobClickPerform:sel withObject:[@(user.userID) stringValue]];
//        [MobClick profileSignInWithPUID:[@(user.userID) stringValue]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    void(^loginFail)(NSError *error) = ^(NSError *error) {
        [CarlAlertView showAlertView:error.domain];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFail object:nil];
    };
    
    if (loginView.isMobelNum)
    {
        [[RkyMailHandler sharedInstance] loginWithMobile:mobeiTxt password:password success:^(RkyUser *user) {
            loginSuccess(user);
        } failure:^(NSError *error) {
            loginFail(error);
        }];
    }else
    {
        [[RkyMailHandler sharedInstance] loginWithEmail:emailTxt password:password success:^(RkyUser *user) {
            loginSuccess(user);
        } failure:^(NSError *error) {
            loginFail(error);
        }];
    }
}

- (void) weixinLoginHandler: (RkyLoginView *) loginView
{
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:kEventLoginWeixinLoginBtn];
//    [MobClick event:kEventLoginWeixinLoginBtn];
    [[RkyWeixinHandler sharedInstance] loginWithSuccess:^(id model) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
    } failure:^(NSError *error) {
        [CarlAlertView showAlertView:error.domain];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFail object:nil];
    }];
}

- (void) registerHandler: (RkyLoginView *) loginView
{
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:kEventRegisterBtn];
//    [MobClick event:kEventRegisterBtn];
    RkyLoginPageRegisterViewController * registerVC = [[RkyLoginPageRegisterViewController alloc] init];
    registerVC.MobClick = self.MobClick;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)forgetPassword:(RkyLoginView *)loginView {
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:kEventLoginFindPasswordBtn];
//    [MobClick event:kEventLoginFindPasswordBtn];
    RkyForgetPasswordViewController *forgetPasswordViewController = [[RkyForgetPasswordViewController alloc] initWithUserName:loginView.mailTextField.text];
    forgetPasswordViewController.MobClick = self.MobClick;
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

-(BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)MobClickPerform:(SEL)sel withObject:(id)obj {
    if(self.MobClick && [self.MobClick respondsToSelector:sel]){
        [self.MobClick performSelector:sel withObject:obj];
    }
}

@end
