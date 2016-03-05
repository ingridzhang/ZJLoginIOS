//
//  RkyRegisterInputView.h
//  EasyJieApp
//
//  Created by ricky on 14-9-2.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RkyCustomTextField.h"

@class RkyRegisterInputView;

@protocol RkyRegisterInputViewDelegate <NSObject>

- (void) registerInputViewHeightChange: (RkyRegisterInputView *) inputView withOffset:(CGFloat) offset;
- (void) registerInputViewCommit: (RkyRegisterInputView *) inputView;
- (void) hideLogoImageAlpha:(BOOL)alphaYN;
@end

@interface RkyRegisterInputView : UIView
@property (nonatomic, strong, readonly) RkyCustomTextField * nickNameInput;
@property (nonatomic, strong, readonly) RkyCustomTextField * emailInput;
@property (nonatomic, strong, readonly) RkyCustomTextField * passwordInput;
@property (nonatomic, weak) id<RkyRegisterInputViewDelegate> delegate;
@property (nonatomic) dispatch_source_t theTimer;

- (void)didTouchMaskView;
-(void)updateTimer;
@end
