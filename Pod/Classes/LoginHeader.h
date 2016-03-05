//
//  LoginHeader.h
//  Pods
//
//  Created by Apple on 16/1/25.
//
//

#ifndef LoginHeader_h
#define LoginHeader_h

#import <UIKit/UIKit.h>
#import <UIKit/UITraitCollection.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "RkySkinKit.h"
#import "RkySkinDefine.h"
#import "RkyLoginMacro.h"
#import "Masonry.h"
#import "UIView+Frame.h"
#import "CarlAlertView.h"
#import "Chameleon.h"
#import "EZApp.h"
#import "RkyLoginUserInfo.h"
#import "ReactiveCocoa.h"
#import "UIImage+Extension.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define SCREENWIDTHRADIO = ((kScreenWidth) / 320.0)
#define SCREENHEIGHTRADIO = ((kScreenHeight) / 320.0)

#define kPointValue(a) (a/2.0)
#define MAS_SHORTHAND

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define SCREEN_RADIO (IS_IPHONE_6P ? 1.1 : 1.0)
#define CGRECTMAKE(LEFT, TOP, WIDTH, HEIGHT) (IS_IPHONE_6P?CGRECTMAKEDEVICE(LEFT, TOP, WIDTH, HEIGHT, 1):CGRECTMAKEDEVICE(LEFT, TOP, WIDTH, HEIGHT, 0))
#define CGRECTMAKECONNACT(A, B) A ## B
#define CGRECTMAKEDEVICE(LEFT, TOP, WIDTH, HEIGHT, DEVICETYPE) CGRECTMAKECONNACT(CGRECT_DEVICE, DEVICETYPE)(LEFT, TOP, WIDTH, HEIGHT)
#define CGRECT_DEVICE0(LEFT, TOP, WIDTH, HEIGHT) CGRectMake(LEFT, TOP, WIDTH, HEIGHT)
#define CGRECT_DEVICE1(LEFT, TOP, WIDTH, HEIGHT) CGRectMake((LEFT)*SCREEN_RADIO, (TOP)*SCREEN_RADIO, \
(WIDTH)*SCREEN_RADIO, (HEIGHT)*SCREEN_RADIO)

static NSString *const kHttpAPIBaseUrl = @"http://easyapi.ezjie.com";
static NSString *const kHttpSocialBaseURL = @"http://community.ezjie.com";
static NSString *const kBaseURL = @"http://userapi.ezjie.cn:81";
static NSString *const kWapBaseURL = @"http://wap.ezjie.cn";
static NSString *const kAdsBaseURL = @"http://ad.ezjie.com";

#endif /* LoginHeader_h */
