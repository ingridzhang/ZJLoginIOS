//
//  RkyNameViewController.m
//  EasyJieApp
//
//  Created by 李世乾 on 15/7/23.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "RkyNameViewController.h"
#import "RkyLoginDefine.h"
#import "RkyNameView.h"
#import "RkyLoginService.h"
#import "LoginHeader.h"

@interface RkyNameViewController () <RkyNameViewDelegate>

@end
@interface RkyNameViewController ()

@end

@implementation RkyNameViewController
{
    UIImageView *logoImageView;
}
@synthesize phoneNum =_phoneNum;
@synthesize codeNum = _codeNum;
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self MobClickPerform:sel withObject:NSStringFromClass([self class])];
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:NSStringFromClass([self class])];
//    [MobClick endLogPageView:NSStringFromClass([self class])];
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
    
    
    RkyNameView *registerView = [[RkyNameView alloc] initWithFrame:CGRectMake(0, oringY, self.view.frame.size.width,self.view.height-oringY)];
    registerView.delegate = self;
    [self.view addSubview:registerView];
    
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
    SEL sel = @selector(event:);
    [self MobClickPerform:sel withObject:kEventRegisterSecBackBtn];
//    [MobClick event:kEventRegisterSecBackBtn];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RkyRegisterInputViewDelegate
- (void) registerInputViewHeightChange: (RkyNameView *) inputView withOffset:(CGFloat) offset{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        inputView.frame = CGRectOffset(inputView.frame, 0, offset);
        
    } completion:nil];
}
- (void) registerInputViewCommit: (RkyNameView *) inputView
{
    
    [RkyLoginService registerUser:@{@"mobile":self.phoneNum, @"password":inputView.passwordInput.text, @"verify_code":self.codeNum, @"nick_name":inputView.nickNameInput.text} success:^(RkyUser *user) {
        [CarlAlertView showAlertView:@"登录成功"];
//        [[RkyDataSource sharedInstance] setupDataSourceWithUser:user];
//        [[RkyDataSource sharedInstance].mainQueueManagedObjectContext saveToPersistentStore:NULL];
        [RkyLoginUserInfo sharedInstance].userInfo = user;
        [[EZApp shareInstance] setLoginUserInfo:[@(user.userID) stringValue] loginKey:user.loginKey];
        [RkyLoginUserInfo sharedInstance].loginType = RkyLoginTypeMail;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRegisterSuccess object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^{
        [CarlAlertView showAlertView:@"注册失败"];
    }];
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
