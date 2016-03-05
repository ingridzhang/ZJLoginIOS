//
//  RkyLoginView.h
//  EasyJie
//
//  Created by ricky on 14-8-26.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RkyCustomTextField.h"

@class RkyLoginView;

@protocol RkyLoginViewDelegate <NSObject>

- (void) loginViewHeightChange: (RkyLoginView *) loginView withOffset:(CGFloat) offset;
- (void) mailLoginHandler: (RkyLoginView *) loginView;
- (void) weixinLoginHandler: (RkyLoginView *) loginView;
- (void) registerHandler: (RkyLoginView *) loginView;
- (void) hideLogoImageAlpha:(BOOL)alphaYN;
- (void) forgetPassword: (RkyLoginView *) loginView;
@end

@interface RkyLoginView : UIView<UITextFieldDelegate>
@property (nonatomic, strong, readonly) RkyCustomTextField *  mailTextField;
@property (nonatomic, strong, readonly) RkyCustomTextField *  passwordTextField;
@property (nonatomic, assign) id<RkyLoginViewDelegate> delegate;
@property (nonatomic,assign) BOOL isMobelNum;

- (void)didTouchMaskView;

@end

