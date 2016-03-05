//
//  RkyLoginMacro.h
//  testLogin
//
//  Created by sun on 15/10/29.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#ifndef RkyLoginMacro_h
#define RkyLoginMacro_h

// 登陆通知事件
static NSString * const kNotificationLoginSuccess =         @"LoginSuccess";
static NSString * const kNotificationLoginFail =            @"LoginFail";
static NSString * const kNotificationLoginCancel =          @"LoginCancel";
static NSString * const kNotificationLoginOut =             @"LoginOut";
static NSString * const kNotificationRegisterSuccess =      @"RegisterSuccess";
static NSString * const kNotificationRegisterFail =         @"RegisterFail";

// 友盟事件
static NSString *const kLoginPage = @"LoginPage";
static NSString *const kRegisterPage = @"RegisterPage";

static NSString *const kEventLoginBackBtn = @"login_backBtn";
static NSString *const kEventLoginFindPasswordBtn = @"login_find_passwordBtn";
static NSString *const kEventLoginUserLoginBtn = @"login_user_loginBtn";
static NSString *const kEventLoginWeixinLoginBtn = @"login_weixin_loginBtn";
static NSString *const kEventRegisterBtn = @"login_registerBtn";
static NSString *const kEventRegisterFirBackBtn = @"register_fir_backBtn";
static NSString *const kEventRegisterFirGetAuthcodeBtn = @"register_fir_get_authcodeBtn";
static NSString *const kEventRegisterFirUserNextBtn = @"register_fir_user_nextBtn";
static NSString *const kEventRegisterFirUserAgreementBtn = @"register_fir_user_agreementBtn";
static NSString *const kEventRegisterSecBackBtn = @"register_sec_backBtn";
static NSString *const kEventRegisterSecShowPawBtn = @"register_sec_show_pawBtn";
static NSString *const kEventRegisterSecUserRegisterBtn = @"register_sec_user_registerBtn";
static NSString *const kEventRegisterSecUserAgreementBtn = @"register_sec_user_agreementBtn";
static NSString *const kEventResetPawFirBackBtn = @"reset_paw_fir_backBtn";
static NSString *const kEventResetPawFirGetAuthcodeBtn = @"reset_paw_fir_get_authcodeBtn";
static NSString *const kEventResetPawFirGetVoiceAuthcodeBtn = @"reset_paw_fir_get_voice_authcodeBtn";
static NSString *const kEventResetPawFirNextBtn = @"reset_paw_fir_nextBtn";
static NSString *const kEventResetPawSecShowPawBtn = @"reset_paw_sec_show_pawBtn";
static NSString *const kEventResetPawSecSureBtn = @"reset_paw_sec_sureBtn";

// appkey
static NSString *const kWeixinAppKey = @"wx0f83f03fbff52826";
static NSString *const kWeixinAppSecret = @"4ab2300f3ada771bd3a5c66f6f21430c";
static NSString *const kUmengAppKey = @"55db0a90e0f55a780f000c1e";

#endif /* RkyLoginMacro_h */
