//
//  RkyRegisterViewController.m
//  EasyJie
//
//  Created by ricky on 14-8-26.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import "RkyLoginPageRegisterViewController.h"
#import "RkyLoginDefine.h"
#import "RkyRegisterInputView.h"
#import "RkyNameViewController.h"
#import "ReactiveCocoa.h"
#import "UIImage+Extension.h"
#import "LoginHeader.h"

@interface RkyLoginPageRegisterViewController () <RkyRegisterInputViewDelegate>

@property (nonatomic, weak) RkyRegisterInputView *registerInputView;

@end

@implementation RkyLoginPageRegisterViewController
{
    UIImageView *logoImageView;
}
- (void)dealloc
{

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

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
    [self MobClickPerform:sel withObject:kRegisterPage];
    
//    [MobClick beginLogPageView:kRegisterPage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SEL sel = @selector(endLogPageView:);
    [self MobClickPerform:sel withObject:kRegisterPage];
//    [MobClick endLogPageView:kRegisterPage];
    if (self.registerInputView.theTimer) {
        dispatch_source_cancel(self.registerInputView.theTimer);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init UI

- (void) initUI
{
    [self buildBackgroundView];
    [self buildUserAndInputView];
    [self buildBackButton];
}

- (void) buildBackgroundView
{
    UIImage * bgImage = [UIImage bundleImage:@"loginDitu.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
}

- (void) buildUserAndInputView
{
    UIImage * userImage = [UIImage bundleImage:@"loginLogo.png" bundleClass:[self class] bundleName:@"EasyLoginIOS"];
//    UIButton * userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [userBtn setBackgroundImage:userImage forState:UIControlStateNormal];
//    userBtn.frame = CGRectMake(kPointValue(270), kPointValue(228), kPointValue(100),kPointValue(100));
//    [self.view addSubview:userBtn];
    
    logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kPointValue(270), kPointValue(228), kPointValue(100),kPointValue(100))];
    logoImageView.centerX = self.view.width / 2;
    logoImageView.image = userImage;
    [self.view addSubview:logoImageView];
    
    float oringY = 265;
    if ([UIScreen mainScreen].bounds.size.height>=1136)
    {
        oringY  = 314;
    }
    
    RkyRegisterInputView *registerView = [[RkyRegisterInputView alloc] initWithFrame:CGRectMake(0, oringY, self.view.frame.size.width,self.view.height-oringY)];
    registerView.delegate = self;
    [self.view addSubview:registerView];
    self.registerInputView = registerView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [registerView didTouchMaskView];
    }];
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

#pragma mark - event
- (void)backBtnClicked:(UIButton *)button
{
    SEL sel = @selector(endLogPageView:);
    [self MobClickPerform:sel withObject:kEventRegisterFirBackBtn];
//    [MobClick event:kEventRegisterFirBackBtn];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - RkyRegisterInputViewDelegate
- (void) registerInputViewHeightChange: (RkyRegisterInputView *) inputView withOffset:(CGFloat) offset{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        inputView.frame = CGRectOffset(inputView.frame, 0, offset);
        
    } completion:nil];
}
- (void) registerInputViewCommit: (RkyRegisterInputView *) inputView
{
    [self.registerInputView updateTimer];
    RkyNameViewController * registerVC = [[RkyNameViewController alloc] init];
    registerVC.phoneNum = inputView.emailInput.text;
    registerVC.codeNum = inputView.passwordInput.text;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

-(void)hideLogoImageAlpha:(BOOL)alphaYN
{
    [UIView animateWithDuration:0.5 animations:^{
        logoImageView.alpha = alphaYN;
    }];
}

- (void)MobClickPerform:(SEL)sel withObject:(id)obj {
    if(self.MobClick && [self.MobClick respondsToSelector:sel]){
        [self.MobClick performSelector:sel withObject:obj];
    }
}

@end
