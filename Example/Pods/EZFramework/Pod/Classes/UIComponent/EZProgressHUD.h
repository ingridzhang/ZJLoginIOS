//
//  EZProgressHub.h
//  EZFramework_example
//
//  Created by sun on 15/10/16.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

typedef NS_ENUM(NSUInteger, EZProgressHUDMaskType) {
    EZProgressHUDMaskTypeNone = 1,
    EZProgressHUDMaskTypeClear,
    EZProgressHUDMaskTypeBlack,
    EZProgressHUDMaskTypeGradient
};

@interface EZProgressHUD : NSObject

+ (void)show;
+ (void)showWithMaskType:(EZProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(EZProgressHUDMaskType)maskType;

// stops the activity indicator, shows a glyph + status, and dismisses HUD a little bit later
+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showInfoWithStatus:(NSString *)string maskType:(EZProgressHUDMaskType)maskType;

+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString*)string maskType:(EZProgressHUDMaskType)maskType;

+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string maskType:(EZProgressHUDMaskType)maskType;

+ (void)dissmiss;

@end
