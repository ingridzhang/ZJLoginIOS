//
//  EZProgressHub.m
//  EZFramework_example
//
//  Created by sun on 15/10/16.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZProgressHUD.h"

@interface EZProgressHUD ()

@end

@implementation EZProgressHUD

+ (void)show {
    [SVProgressHUD show];
}

+ (void)showWithMaskType:(EZProgressHUDMaskType)maskType {
    [SVProgressHUD showWithMaskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showWithStatus:(NSString*)status {
    [SVProgressHUD showWithStatus:status];
}

+ (void)showWithStatus:(NSString*)status maskType:(EZProgressHUDMaskType)maskType {
    [SVProgressHUD showWithStatus:status maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showInfoWithStatus:(NSString *)string {
    [SVProgressHUD showInfoWithStatus:string];
}

+ (void)showInfoWithStatus:(NSString *)string maskType:(EZProgressHUDMaskType)maskType {
    [SVProgressHUD showInfoWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showSuccessWithStatus:(NSString*)string {
    [SVProgressHUD showSuccessWithStatus:string];
}

+ (void)showSuccessWithStatus:(NSString*)string maskType:(EZProgressHUDMaskType)maskType {
    [SVProgressHUD showSuccessWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showErrorWithStatus:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showErrorWithStatus:(NSString *)string maskType:(EZProgressHUDMaskType)maskType {
    [SVProgressHUD showErrorWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)dissmiss {
    [SVProgressHUD dismiss];
}

@end
